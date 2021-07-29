extends Node

# Imports
const Telemetry = preload("./defs/Telemetry.gd")

# path to playerRoot
export (NodePath) var pathToRigidbody
export (NodePath) var pathToModulesRoot
export (float) var thrust = 10
export (float) var angularThrust = 50
export (float) var sasStrength = 0.01

var rigidbody : RigidBody2D

# Signals
signal move(delta, movement)
signal rotate(delta, rotation)
signal telemetry(delta, telemetry)

# State
var sasEnabled: bool = false
var rb : RigidBody2D
func _enter_tree():
	rigidbody = get_node(pathToRigidbody) as RigidBody2D

	var modulesRoot: Node2D = get_node(pathToModulesRoot) as Node2D
	var modules: Array = modulesRoot.get_children() as Array
	for module in modules:
		rb = module as RigidBody2D
#		rb.mode = RigidBody2D.MODE_KINEMATIC
#		rb.apply_central_impulse(Vector2.ZERO)
		rigidbody.mass+= rb.mass

func _physics_process(delta):
	var movement = handleLinear(delta)
	var rotation = handleAngular(delta)
	handleSas(delta, movement, rotation)

	act(movement, rotation)
#	rb.apply_central_impulse(movement * thrust)

	# tell everyone all actions
	emit_signal("rotate", delta, rotation)
	emit_signal("move", delta, movement)
	emit_signal("telemetry", delta, getTelemetry())


func getTelemetry() -> Telemetry:
	return Telemetry.new(
		rigidbody.linear_velocity,
		rigidbody.angular_velocity,
		rigidbody.rotation_degrees,
		sasEnabled
	)

func act(move: Vector2, rotate: float):
	move.x = clamp(move.x, -1, 1)
	move.y = clamp(move.y, -1, 1)
	rotate = clamp(rotate, -1, 1)


	rigidbody.apply_torque_impulse(rotate * angularThrust)
	rigidbody.apply_central_impulse(move.rotated(rigidbody.rotation) * thrust)

func handleLinear(delta) -> Vector2:
	var inputVector = Vector2.ZERO
	inputVector.x = Input.get_action_strength("go_right") - Input.get_action_strength("go_left")
	inputVector.y = Input.get_action_strength("go_down") - Input.get_action_strength("go_up")
	return inputVector * delta

func handleAngular(delta) -> float:
	var rotation = Input.get_action_strength("rotate_right") - Input.get_action_strength("rotate_left")
	return rotation * delta

func handleSas(delta: float, inputVector, inputRotate):
	if Input.is_action_just_pressed("sas"):
		sasEnabled = !sasEnabled
	sas(delta, sasEnabled, inputVector, inputRotate)

func sas(delta: float, enabled: bool, inputVector: Vector2, inputRotate: float):
	if enabled:
		linear_sas(delta, true, inputVector)
		angular_sas(delta, true, inputRotate)

func angular_sas(delta: float, enabled: bool, inputRotate: float):
	# no sas if there's input
	# otherwise max rotationspeed is limited by sas
	if enabled and abs(inputRotate) == 0:
		# default sasImpulse
		var currentAngularSpeed = rigidbody.angular_velocity
		var sasAngularImpulse : float = rigidbody.angular_velocity * -1 * sasStrength

		if currentAngularSpeed < 10 and currentAngularSpeed > 1:
			sasAngularImpulse = clamp(rigidbody.angular_velocity * -1, -1, 1)
		elif currentAngularSpeed <= 1:
			sasAngularImpulse = rigidbody.angular_velocity * -1

		sasAngularImpulse *= delta

		emit_signal("rotate", delta, sasAngularImpulse)
		act(Vector2.ZERO, sasAngularImpulse)

func linear_sas(delta: float, enabled: bool, inputVector: Vector2):
	if enabled:
		# default sasImpulse
		var currentSpeed = rigidbody.linear_velocity.length()
		var sasImpulse : Vector2 = rigidbody.linear_velocity.rotated(rigidbody.rotation * -1) * -1 * sasStrength

		# no sas if there's input
		# otherwise max speed is limited by sas
		if inputVector.x != 0:
			sasImpulse.x = 0

		if inputVector.y != 0:
			sasImpulse.y = 0

		# no further calculations needed
		if sasImpulse.length() == 0:
			return

		if currentSpeed < 10 and currentSpeed > 0.1:
			sasImpulse = rigidbody.linear_velocity.normalized().rotated(rigidbody.rotation * -1) * (sasStrength * 10) * -1
		elif currentSpeed <= 0.1:
			sasImpulse = rigidbody.linear_velocity.rotated(rigidbody.rotation * -1) * -1

		sasImpulse *= delta

		emit_signal("move", delta, sasImpulse)
		act(sasImpulse, 0)
