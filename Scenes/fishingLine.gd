extends Node3D

@export var _first: bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	if (_first):
		LineGlobal._posA = position
	else: 
		LineGlobal._posB = position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
