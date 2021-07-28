var movementVector: Vector2
var rotationSpeed: float
var currentRotation: float
var sasEnabled: bool

func _init(movementVector: Vector2, rotationSpeed: float, currentRotation: float, sasEnabled: bool):
	self.movementVector = movementVector
	self.rotationSpeed = rotationSpeed
	self.currentRotation = currentRotation
	self.sasEnabled = sasEnabled
