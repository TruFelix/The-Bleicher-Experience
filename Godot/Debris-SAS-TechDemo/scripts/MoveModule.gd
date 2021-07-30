extends RigidBody2D

const Movement = preload("res://scripts/defs/Movement.gd")

export (Vector2) var thrustInDirections
export (Dictionary) var linearResourceConsumption
export (Dictionary) var angularResourceConsumption

# returns an dictionary of required Resources
func requiredResources(movement: Movement) -> Dictionary:
	# TODO: ...
	return {}
