extends Area2D

var speed = 200
var direction: Vector2
var velocity: Vector2
var on_move = false


func _process(delta):
	if on_move:
		position += velocity * speed

func set_direction(initial_position: Vector2, tajert_position: Vector2):
	velocity = (tajert_position - initial_position).normalized()
	on_move = true


func _on_area_entered(area):
	if area.is_in_group("enemies"):
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
