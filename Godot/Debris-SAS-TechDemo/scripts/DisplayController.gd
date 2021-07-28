extends Node

const Telemetry = preload("./defs/Telemetry.gd")

export (NodePath) var pathToUIRoot

export (Dictionary) var resourceLabels = {
	'fuel': {
		'path': null,
		'prefix': 'Ful: '
	}
}

export (NodePath) var pathTospeedLabel
export (NodePath) var pathToSasLabel
export (NodePath) var pathToSasIndicator

func _on_Resources_resourceChange(name: String, newAmount: float):
	var label: Label = get_node(resourceLabels[name]['path']) as Label
	label.text = resourceLabels[name]['prefix'] + String(stepify(newAmount, 0.001))


func _on_Movement_telemetry(delta: float, telemetry: Telemetry):
	couteractPlayerRotation(telemetry.currentRotation)
	
	var speedLabel: Label = get_node(pathTospeedLabel) as Label
	speedLabel.text = 'Spd: ' + String(stepify(telemetry.movementVector.length(), 0.001))
	
	var sasLabel: Label = get_node(pathToSasLabel) as Label
	sasLabel.text = 'Sas: '
	if telemetry.sasEnabled:
		sasLabel.text += 'engaged'
	else:
		sasLabel.text += 'disengaged'
	
	
func couteractPlayerRotation(currentPlayerRotation: float):
	var ui: Control = get_node(pathToUIRoot)
	ui.rect_rotation = -currentPlayerRotation
