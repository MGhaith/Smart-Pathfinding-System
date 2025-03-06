extends CharacterBody3D

@export_category("Player Nodes")
@export var _camera_z_rotator: Node3D
@export var _camera_y_rotator: Node3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var _mouse_sensetivity = 0.01

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		_camera_z_rotator.rotate_y(event.relative.x * _mouse_sensetivity)
		_camera_y_rotator.rotate_z(event.relative.y * _mouse_sensetivity)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("backward", "forward", "move_left", "move_right")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
