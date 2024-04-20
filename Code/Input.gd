extends Node

var _joy1: Vector2
var _actionButton: bool
var _longActionButton: bool
var _actionRelease: bool
var _cancelButton: bool

func _process(_delta):
	# Vector for determining direction
	# WASD controls
	_joy1 = Vector2(Input.get_action_strength("Joy1Right") - Input.get_action_strength("Joy1Left"), 
	Input.get_action_strength("Joy1Up") - Input.get_action_strength("Joy1Down"))
	
	# E key for Interact
	_actionButton = Input.is_action_just_pressed("Interact")
	_actionRelease = Input.is_action_just_released("Interact")
	
	# Space key
	_longActionButton = Input.is_action_pressed("StateBasedAction") 
	# Esc Key
	_cancelButton = Input.is_action_pressed("exit")
