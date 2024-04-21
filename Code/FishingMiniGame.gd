extends Control

# Define the speed at which the line moves and the boundaries within which it can move
var moving_speed = 100  # pixels per second
var max_x = 800  # maximum x position of the moving line
var min_x = 100  # minimum x position of the moving line
var direction = 1  # initial direction to move (1 for right, -1 for left)

# This function is called when the node is added to the scene for the first time
func _ready():
	# Enable the processing of this node, which allows _process to be called
	set_process(true)
	# Ensure the MovingLine node exists and is accessible
	if not get_node_or_null("MovingLine"):
		print("Error: MovingLine node cannot be found.")
		set_process(false)  # Stop processing if node is not found

# This function is called every frame, and 'delta' is the elapsed time since the previous frame
func _process(delta):
	var moving_line = get_node_or_null("MovingLine")
	if moving_line:
		var current_x = moving_line.position.x  # Get the current x position of the line
		# Reverse direction if the line reaches the boundaries
		if current_x >= max_x or current_x <= min_x:
			direction *= -1
		# Update the position of the line based on the direction and speed
		current_x += direction * moving_speed * delta
		moving_line.position.x = current_x  # Set the new position

		# Check for mouse clicks to determine if the fish is caught
		if Input.is_action_just_pressed("mouse_click"):
			# Check if the line is within the blue zone when clicked
			if current_x >= 350 and current_x <= 500:
				print("Fish Caught")
			else:
				print("Fish Escaped")
	else:
		print("Error: MovingLine node is not available.")
