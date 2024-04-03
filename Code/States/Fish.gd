extends Node
class_name Fish

# Define enum for fish states
enum FishState 
{
	UNCATCHABLE,
	CATCHABLE
}

# Current state of the fish
var current_state = FishState.UNCATCHABLE

func _ready():
	# Start the fish behavior loop
	set_process(true)

func _process(delta):
	# Update fish behavior based on current state
	match current_state:
		FishState.UNCATCHABLE:
			# Fish is not catchable, implement behavior here
			Uncatchable()
		FishState.CATCHABLE:
			# Fish is catchable, implement behavior here
			Catchable()

# Behavior when fish is uncatchable
func Uncatchable():
	# Example: Fish swims around randomly
	# Implement behavior here
	pass

# Behavior when fish is catchable
func Catchable():
	# Example: Fish swims closer to the bait
	# Implement behavior here
	pass

# Function to change the state of the fish
func SetState(state: FishState):
	current_state = state
	pass
