extends Area2D

@export var speed = 1500

var points = []
var tarjet: Node2D = null
var tarjet_index = 0

var velocity: Vector2 = Vector2.ZERO

var is_persecution = false

func _ready():
	if has_node("path"):
		for point in get_node("path").get_children():
			points.append(point)
	
	if points.size() > 0:
		tarjet = points[0]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if tarjet != null:
		velocity = position.direction_to(tarjet.position) * speed

	if tarjet != null:
		if is_persecution == false:
			if position.distance_to(tarjet.position) > 100:
				position += velocity * delta
			else:
				if tarjet_index < (points.size() - 1):
					tarjet_index += 1
					tarjet = points[tarjet_index]
				else:
					tarjet = points[0]
					tarjet_index = 0
		else:
			if position.distance_to(tarjet.position) > 200:
				position += velocity * delta
				
	


func _on_player_detector_area_entered(area):
	if area.is_in_group("players"):
		tarjet = area
		is_persecution = true


func _on_player_detector_area_exited(area):
	if area.is_in_group("players"):
		if points.size() > 0:
			tarjet = points[tarjet_index]
		is_persecution = false
