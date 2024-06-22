extends StaticBody2D

@export_range(0, 2000, 10, 'suffix:px/s') var speed: float

var p_width : int
var win_width : int

func _ready():
	win_width = get_viewport_rect().size.x
	p_width = $ColorRect.get_size().x
	
func _process(delta):
	if Input.is_action_pressed("right"):
		position.x += speed * delta
	elif Input.is_action_pressed("left"):
		position.x -= speed * delta
	
	position.x = clamp(position.x, p_width/2, win_width - p_width/2)
		
