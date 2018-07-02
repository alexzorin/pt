extends KinematicBody

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var cam

var gravity = -9
var speed = 500

var pitch = 0
var yaw = 0

var velocity = Vector3()

func _ready():
	cam = get_node("Camera")
	set_physics_process(true)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _physics_process(delta):
	var direction = Vector3()
	var cam_xform = cam.get_camera_transform()

	if Input.is_key_pressed(KEY_W):
		direction += -cam_xform.basis[2]
	if Input.is_key_pressed(KEY_S):
		direction += cam_xform.basis[2]
	if Input.is_key_pressed(KEY_A):
		rotation.y += deg2rad(2)
	if Input.is_key_pressed(KEY_D):
		rotation.y += deg2rad(-2)
	direction = direction.normalized()
	direction = direction * speed * delta

	velocity.y += gravity * delta
	velocity.x = direction.x
	velocity.z = direction.z
	
	velocity = move_and_slide(velocity, Vector3(0, 1, 0))
	
	if is_on_floor() and Input.is_key_pressed(KEY_SPACE):
		velocity.y = 7