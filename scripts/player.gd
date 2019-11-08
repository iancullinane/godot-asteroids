extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const TURN_SPEED = 180

const MOVE_SPEED = 150
const VERTICAL_SPEED = Vector2(1,1)
const ACC = 0.05
const DEC = 0.01

var motion = Vector2(0,0)
var screen_size
var screen_buffer = 8

#var direction = get_viewport().get_mouse_position() - position
var Projectile = preload('res://scenes/Projectile.tscn')

func _ready():
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
		
	if Input.is_action_pressed("input_left"):
		rotation_degrees -= TURN_SPEED * delta
	if Input.is_action_pressed("input_right"):
		rotation_degrees += TURN_SPEED * delta
	if Input.is_action_pressed("ui_up"):
		scale -= VERTICAL_SPEED * delta
	if Input.is_action_pressed("ui_down"):
		scale += VERTICAL_SPEED * delta
			
	var thrustDir = Vector2(1,0).rotated(rotation)
	
	if Input.is_action_pressed("input_forward"):
		motion = motion.linear_interpolate(thrustDir, ACC)
	else:
		motion = motion.linear_interpolate(Vector2(0,0), DEC)
		
	if Input.is_action_just_pressed('ui_up'):
        var projectile = Projectile.instance()  # Create a projectile.
        # Set the position, rotation and velocity.
        projectile.position = position
   #     projectile.rotation = direction.angle()
   #     projectile.vel = direction.normalized() * 5  # Scale to length 5.
        get_parent().add_child(projectile)

	
	position += motion * MOVE_SPEED * delta
	
	position.x = wrapf(position.x, -screen_buffer, screen_size.x + screen_buffer)
	position.y = wrapf(position.y, -screen_buffer, screen_size.y + screen_buffer)



