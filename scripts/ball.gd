extends CharacterBody2D

var win_size : Vector2
var speed : int
var dir : Vector2
const MAX_X_VECTOR : float = 0.6

@export_range(0, 2000, 10, 'suffix:px/s')
var start_speed : float

func _ready():
	win_size = get_viewport_rect().size
	
func new_ball():
	position.y = win_size.y/2
	position.x = randi_range(200, win_size.x - 200)
	speed = start_speed
	dir = random_direction()

func random_direction():
	var new_dir := Vector2()
	new_dir.x = randf_range(-1,1)
	new_dir.y = 1
	return new_dir.normalized()

func new_direction(collider):
	var ball_x = position.x
	var pad_x = collider.position.x
	var dist = ball_x - pad_x
	var new_dir := Vector2()
	
	if dir.y > 0:
		new_dir.y = -1
	else:
		new_dir.y = 1 
	new_dir.x = (dist / (collider.p_width / 2)) * MAX_X_VECTOR
	return new_dir.normalized()
	
func _physics_process(delta):
	var collision = move_and_collide(dir * speed * delta)
	var collider
	if collision:
		collider = collision.get_collider()
		if collider == $"../paddle":
			dir = new_direction(collider)
		else:
			dir = dir.bounce(collision.get_normal())

	move_and_slide()



func _on_area_2d_body_entered(body):
	if body is RigidBody2D:
		body.queue_free()
