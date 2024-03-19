extends State
class_name Fishing

func Enter():
	print("State: Fishing")
	print("Press and hold [space] to start game")

func Exit():
	pass

func Update(_delta: float):
	if GlobalInput._shiftleft:
		print("Aimed left")
		
	if GlobalInput._shiftright:
		print("Aimed right")
		
	if GlobalInput._actionButton:
		ChangeState.emit(self, "MiniGame")
		
	if GlobalInput._cancelButton:
		print("Stopped Fishing")
		ChangeState.emit(self, "Idle")

func PhysicsUpdate(_delta: float):
	pass
