extends State
class_name MiniGame

var _totalTime = 0
func Enter():
	print("Mini game started")

func Exit():
	print("Mini game over")

func _process(delta):
	if GlobalInput._longActionButton:
		_totalTime += delta
	
	if GlobalInput._actionRelease:
		print("action held for " + str(_totalTime) + " seconds")
		
		if _totalTime >= 5:
			print("Big Fish!!!")
		elif _totalTime >= 2:
			print("Fish!")
		else:
			print("Small Fish...")
			
		ChangeState.emit(self, "Fishing")
	
	if GlobalInput._cancelButton:
		ChangeState.emit(self, "Fishing")

func PhysicsUpdate(_delta: float):
	pass
