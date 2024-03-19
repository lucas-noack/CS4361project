extends Node

var _joy1: Vector2
var _actionButton: bool
var _actionRelease: bool
var _cancelButton: bool
var _shiftleft: bool
var _shiftright: bool

func _process(_delta):
	# Vector for determining 
	_joy1 = Vector2(Input.get_action_strength("Joy1Right") - Input.get_action_strength("Joy1Left"), 
	Input.get_action_strength("Joy1Up") - Input.get_action_strength("Joy1Down")) # arrow keys
	
	_actionButton = Input.is_action_pressed("Interact") # space bar
	
	_actionRelease = Input.is_action_just_released("Interact")
	
	_cancelButton = Input.is_action_pressed("Cancel") # alt + space
	
	_shiftleft = Input.is_action_just_pressed("Joy1Left")
	
	_shiftright = Input.is_action_just_pressed("Joy1Right")
	
