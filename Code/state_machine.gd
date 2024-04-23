extends Node3D

@export var _initialState : Base

var _currentState: State
var _states: Dictionary = {}
# Called when the node enters the scene tree for the first time.
func _ready():
	GetStates()
	
	if _initialState:
		_initialState.Enter()
		_currentState = _initialState

func GetStates():
	for child in get_children():
		if child is State:
			_states[child.name] = child
			child.ChangeState.connect(OnChildChangeState)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if _currentState:
		_currentState.Update(delta)

func _physics_process(delta):
	if _currentState:
		_currentState.PhysicsUpdate(delta)

func OnChildChangeState(state, newStateName):
	if state != _currentState:
		return
		
	var _newState = _states.get(newStateName)
	if !_newState:
		return
		
	if _currentState:
		_currentState.Exit()
		
	_newState.Enter()
	
	_currentState = _newState
