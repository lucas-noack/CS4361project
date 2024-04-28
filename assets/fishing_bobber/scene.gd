extends Node3D

@onready var rod_tip = $"../rod_tip"

var target_length : float = -300
var target_position : Vector3 = $"../rod_tip".positon - Vector3(0, 300, 0)
var k = 2.0
var damping = 0.95

func _physics_process(delta):
	var point_to_target : Vector3 = target_position - position
	var length : float = point_to_target.length()
	var spring_force : float = (target_length - length) * -k
	
	var spring_motion : Vector3 = spring_force * point_to_target.normalized()
	
	motion += spring_motion
	
	
