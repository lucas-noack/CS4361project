extends Control

var moving_speed = 100 # pixels per second
var max_x = 800 # max x-value of the moving line
var min_x = 100 # minimum x-value of the moving line
var direction = 1 # start moving right

func_ _ready():
    # Set up the update function
    set_process(true)

func_ _process(delta):
    var current_x = get_node("../MovingLine").get_position().x
    if current_x >= max_x or current_x <= min_x:
        direction *= -1
    current_x += direction * moving_speed * delta
    get_node("../MovingLine").set_position(Vector(2, current_x, 250))

    # Check if the user has clicked the mouse
    if Input.is_action_just_pressed("mouse_click"):
        # Check if the click was while the line was within the blue area
        if current_x in range(350, 500): # blue area range
            print("Fish Caught")
        else:
            print("Fish Escaped")