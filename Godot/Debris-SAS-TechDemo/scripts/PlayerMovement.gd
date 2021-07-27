extends Node

# path to playerRoot
export (NodePath) var pathToRigidbody
export (float) var speed = 200
export (float) var sasStrength = 0.01

onready var rigidbody : RigidBody2D = get_node(pathToRigidbody) as RigidBody2D

var sasEnabled: bool = false

func _ready():
	print(pathToRigidbody)

func _process(delta):
	var inputVector: Vector2 = Vector2.ZERO
	
	inputVector.x = Input.get_action_strength("go_right") - Input.get_action_strength("go_left")
	inputVector.y = Input.get_action_strength("go_up") - Input.get_action_strength("go_down")
	
	if Input.is_action_just_pressed("sas"):
		sasEnabled = !sasEnabled
		print('sas enabled: ', sasEnabled)
	
	sas(sasEnabled)
	
	rigidbody.apply_central_impulse(inputVector * speed * delta)

func sas(enabled: bool):
	linear_sas(enabled)
	angular_sas(enabled)
	
func angular_sas(enabled: bool):
	if enabled:
		# default sasImpulse
		var currentAngularSpeed = rigidbody.angular_velocity
		var sasAngularImpulse : float = rigidbody.angular_velocity * -1 * sasStrength
		
		if currentAngularSpeed < 10 and currentAngularSpeed > 1:
			sasAngularImpulse = clamp(rigidbody.angular_velocity * -1, -1, 1)
		elif currentAngularSpeed <= 1:
			sasAngularImpulse = rigidbody.angular_velocity * -1
			
		return rigidbody.apply_torque_impulse(sasAngularImpulse)

func linear_sas(enabled: bool):
	if enabled:
		# default sasImpulse
		var currentSpeed = rigidbody.linear_velocity.length()
		var sasImpulse : Vector2 = rigidbody.linear_velocity * -1 * sasStrength
		var sasSpeed = sasImpulse.length()
		
		if currentSpeed < 10 and currentSpeed > 1:
			sasImpulse = rigidbody.linear_velocity.normalized() * -1
		elif currentSpeed <= 1:
			sasImpulse = rigidbody.linear_velocity * -1
			
		return rigidbody.apply_central_impulse(sasImpulse)
