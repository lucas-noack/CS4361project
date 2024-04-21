extends Node3D

var _rotSpeed: float = 0;
@export var _timerBack: float = 0;
@export var _timerForward: float = 0;
@export var _rotBack: float = 0.009
@export var _rotForward: float = -0.009

# Called when the node enters the scene tree for the first time.
func _ready():
	coroutine(_timerBack, _timerForward)	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	cast(_rotSpeed)
	
func coroutine(_wait: float, _waitAgain: float):
	print("start back")
	_rotSpeed = _rotBack
	await get_tree().create_timer(_wait).timeout;
	print("wait")
	_rotSpeed = 0
	await get_tree().create_timer(0.1).timeout;
	print("start forward")
	_rotSpeed = _rotForward
	await get_tree().create_timer(_waitAgain).timeout;
	_rotSpeed = 0
	print("End")	

func cast(_frameAmt: float):
	rotate_z(_frameAmt)
