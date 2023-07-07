extends Area2D


@export var speed = 2500

var tarjet: Area2D = null

var velocity: Vector2 = Vector2.ZERO

func _process(delta):
	if tarjet != null:
		velocity = position.direction_to(tarjet.position) * speed
	
	$Sprite2D.flip_h = velocity.x >= 1
		
	if tarjet != null and position.distance_to(tarjet.position) > 800:
		position += velocity * delta


func set_tarjet(tarjet):
	self.tarjet = tarjet


func _on_visible_on_screen_notifier_2d_screen_entered():
	set_process(true)


func _on_visible_on_screen_notifier_2d_screen_exited():
	if tarjet == null:
		set_process(false)
