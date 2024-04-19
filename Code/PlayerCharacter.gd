extends CharacterBody3D

@onready var MainCamera = get_node("FPSCamera")
const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var CameraRotation = Vector2(0,0)
var mouse_sensitivity = 0.002

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if GlobalInput._actionButton and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = GlobalInput._joy1
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if event is InputEventMouseMotion:
		var MouseEvent = event.relative * mouse_sensitivity
		CameraLook(MouseEvent)
		
func CameraLook(Movement: Vector2):
	CameraRotation += Movement
	CameraRotation.y = clamp(CameraRotation.y, -1.5, 1.2)
	
	transform.basis = Basis()
	MainCamera.transform.basis = Basis()
	
	rotate_object_local(Vector3(0,1,0), -CameraRotation.x)
	MainCamera.rotate_object_local(Vector3(1,0,0), -CameraRotation.y)
