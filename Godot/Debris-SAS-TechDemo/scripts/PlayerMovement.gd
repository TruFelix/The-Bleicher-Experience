extends Node

# Imports
const Telemetry = preload("./defs/Telemetry.gd")

# path to playerRoot
export (NodePath) var pathToRigidbody
export (float) var thrust = 10
export (float) var sasStrength = 0.01

onready var rigidbody : RigidBody2D = get_node(pathToRigidbody) as RigidBody2D

# Signals
signal move(delta, movement)
signal rotate(delta, rotation)
signal telemetry(delta, telemetry)

# State
var sasEnabled: bool = false

func _process(delta):
	var movement = handleLinear(delta)
	var rotation = handleAngular(delta)
	handleSas(delta, movement, rotation)
	
	act(movement, rotation)
	
	# tell everyone all actions
	emit_signal("move", delta, movement)
	emit_signal("rotate", delta, rotation)
	emit_signal("telemetry", delta, getTelemetry())


func getTelemetry() -> Telemetry:
	return Telemetry.new(
		rigidbody.linear_velocity,
		rigidbody.angular_velocity,
		rigidbody.rotation_degrees,
		sasEnabled
	)

func act(move: Vector2, rotate: float):
	rigidbody.apply_central_impulse(move * thrust)
	rigidbody.apply_torque_impulse(rotate * thrust)

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
	linear_sas(delta, enabled, inputVector)
	angular_sas(delta, enabled, inputRotate)

func angular_sas(delta: float, enabled: bool, inputRotate: float):
	# no sas if there's input
	# otherwise max rotationspeed is limited by sas
	if enabled and abs(inputRotate) == 0:
		# default sasImpulse
		var currentAngularSpeed = rigidbody.angular_velocity
		var sasAngularImpulse : float = rigidbody.angular_velocity * -1 * sasStrength
		
		if currentAngularSpeed < 10 and currentAngularSpeed > 0.1:
			sasAngularImpulse = clamp(rigidbody.angular_velocity * -1, -1, 1)
		elif currentAngularSpeed <= 0.1:
			sasAngularImpulse = rigidbody.angular_velocity * -1
			
		sasAngularImpulse *= delta
		
		emit_signal("rotate", delta, sasAngularImpulse)
		return rigidbody.apply_torque_impulse(sasAngularImpulse)

func linear_sas(delta: float, enabled: bool, inputVector: Vector2):
	if enabled:
		# default sasImpulse
		var currentSpeed = rigidbody.linear_velocity.length()
		var sasImpulse : Vector2 = rigidbody.linear_velocity * -1 * sasStrength
		
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
			sasImpulse = rigidbody.linear_velocity.normalized() * (sasStrength * 10) * -1
		elif currentSpeed <= 0.1:
			sasImpulse = rigidbody.linear_velocity * -1
		
		sasImpulse *= delta
		
		emit_signal("move", delta, sasImpulse)
		return rigidbody.apply_central_impulse(sasImpulse)
