extends State
class_name Moving


func Enter():
	print("State: Moving")

func Exit():
	pass

func Update(_delta: float):
	if GlobalInput._joy1 == Vector2.ZERO:
		ChangeState.emit(self, "Idle")
		
func PhysicsUpdate(_delta: float):
	pass
