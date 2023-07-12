extends Sprite2D

@export var speed: float = 400.0

var is_flip_h: bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var input_direction = Input.get_vector("left", "right", "up", "down")
	position += input_direction * speed * delta
	
	if Input.is_action_pressed("right"):
		is_flip_h = true
	
	if Input.is_action_pressed("left"):
		is_flip_h = false
		
	flip_h = is_flip_h
