extends Node

export (NodePath) var pathToDisplayController
export (NodePath) var pathToMovementController
export (float) var initialFuel = 1000
export (float) var fuelConsumption = 0.01

onready var displayController : Node = get_node(pathToDisplayController)

# Signals
signal resourceChange(name, newAmount)

# State
var fuel: float = initialFuel

func _on_Movement_move(delta, inputVector):
	fuel -= inputVector.length() * fuelConsumption
	emit_signal("resourceChange", "fuel", fuel)


func _on_Movement_rotate(delta, rotation):
	fuel -= abs(rotation) * fuelConsumption
	emit_signal("resourceChange", "fuel", fuel)
