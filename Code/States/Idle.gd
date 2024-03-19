extends State
class_name Idle


func Enter():
	print("State: Idle")

func Exit():
	pass

func Update(_delta: float):
	if GlobalInput._joy1 != Vector2.ZERO:
		ChangeState.emit(self, "Moving")
	
	if GlobalInput._actionButton:
		ChangeState.emit(self, "Fishing")

func PhysicsUpdate(_delta: float):
	pass
