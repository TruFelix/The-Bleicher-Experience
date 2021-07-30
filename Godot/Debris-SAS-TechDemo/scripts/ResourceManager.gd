extends Node

const Movement = preload("res://scripts/defs/Movement.gd")
const MoveModule = preload("res://scripts/MoveModule.gd")
const ResourceModule = preload("res://scripts/ResourceModule.gd")

export (NodePath) var pathToModulesRoot

var modulesRoot: Node2D

func _enter_tree():
	modulesRoot = get_node(pathToModulesRoot)

func requestMovement(movement: Movement):
	var availableResources: Dictionary = getAvailableResources()
	if availableResources.empty():
		return false
	var neededResources = getNeededResources(movement)
	if includes(availableResources, neededResources):
		return true

func getAvailableResources() -> Dictionary:
	var availableResources: Dictionary = {}
	var available: Dictionary
	
	var nodes = modulesRoot.get_children()
	for node in nodes:
		if node is ResourceModule:
			available = node.availableResources
			add(available, availableResources)
	
	return availableResources

func getNeededResources(movement: Movement) -> Dictionary:
	var neededResources: Dictionary = {}
	var required: Dictionary
	
	var nodes = modulesRoot.get_children()
	for node in nodes:
		if node is MoveModule:
			required = node.requiredResources(movement)
			add(required, neededResources)
	
	return neededResources

func add(d: Dictionary, to: Dictionary):
	for key in d.keys():
		if to.has(key):
			to[key] += d[key]
		else:
			to[key] = d[key]

func includes(dict1: Dictionary, dict2: Dictionary) -> Dictionary:
	return {}
