extends RigidBody2D

export (Dictionary) var initialAvailableResources

var availableResources: Dictionary

func _enter_tree():
	availableResources = initialAvailableResources.duplicate(true)
