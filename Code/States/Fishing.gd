extends State
class_name Fishing

func Enter():
	print("State: Fishing")
	print("Press and hold [space] to start game")

func Exit():
	pass

func Update(_delta: float):
	if GlobalInput._joy1.x < 0:
		print("Aim left")
		
	if GlobalInput._joy1.x > 0:
		print("Aim right")
		
	if GlobalInput._joy1.y > 0:
		print("Aim up")
	
	if GlobalInput._joy1.y < 0:
		print("Aim down")
	
	if GlobalInput._actionButton:
		ChangeState.emit(self, "MiniGame")
		
	if GlobalInput._cancelButton:
		print("Stopped Fishing")
		ChangeState.emit(self, "Idle")

func PhysicsUpdate(_delta: float):
	pass
