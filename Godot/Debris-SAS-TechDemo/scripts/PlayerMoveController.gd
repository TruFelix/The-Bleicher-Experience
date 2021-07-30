extends Node

# Imports
const ResourceManager = preload("res://scripts/ResourceManager.gd")
const Movement = preload("res://scripts/defs/Movement.gd")

# Exports
export (NodePath) var pathToResourceManager

# State
var linearMovementInput: Vector2
var angularMovementInput: float
# State

# constant variables
var resourceManager: ResourceManager

func _enter_tree():
	resourceManager = get_node(pathToResourceManager) as ResourceManager

func _process(delta):
	getInput()

func _physics_process(delta):
	var movement = Movement.new(linearMovementInput, angularMovementInput)
	resourceManager.requestMovement(movement)
	
# functions
# InputHandling
func getInput():
	linearMovementInput = handleLinear()
	angularMovementInput = handleAngular()
	
func handleLinear() -> Vector2:
	var inputVector = Vector2.ZERO
	inputVector.x = Input.get_action_strength("go_right") - Input.get_action_strength("go_left")
	inputVector.y = Input.get_action_strength("go_down") - Input.get_action_strength("go_up")
	return inputVector
	
func handleAngular() -> float:
	var rotation = Input.get_action_strength("rotate_right") - Input.get_action_strength("rotate_left")
	return rotation
