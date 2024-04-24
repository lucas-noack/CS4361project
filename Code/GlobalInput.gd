extends Node

var _joy1: Vector2
var _WASD: Vector2
var _lookDir: Vector2
var _actionButton: bool
var _longActionButton: bool
var _actionRelease: bool
var _cancelButton: bool

func _process(_delta):
	# Vector for determining direction
	# WASD controls
	_WASD = Input.get_vector("Joy1Left", "Joy1Right", "Joy1Up", "Joy1Down")
	
	# E key for Interact
	_actionButton = Input.is_action_just_pressed("Interact")
	_actionRelease = Input.is_action_just_released("Interact")
	
	# Space key
	_longActionButton = Input.is_action_pressed("StateBasedAction") 
	# Esc Key
	_cancelButton = Input.is_action_pressed("exit")
	
	# uses arrow keys for look direction 
	_lookDir = Input.get_vector("look_left","look_right","look_up","look_down")
