extends Marker2D

var bullet_scene = preload("res://player_bullet.tscn")
var manager: Node = null

func _ready():
	manager = get_node("/root/GameManager")

func fire(map):
	var attackeds = []
	var i = 0;
	for body in $EnemyDetector.get_overlapping_bodies().filter(func(item): return item.is_in_group("enemies")):
		if attackeds.has(body):
			continue
		else:
			attackeds.append(body)
		for start_point in get_children().filter(func(item): return item.is_in_group("fireflies")):
			var bullet_instance = bullet_scene.instantiate()
			bullet_instance.transform = start_point.get_global_transform()
			map.add_child(bullet_instance)
			bullet_instance.set_direction(start_point.get_global_position(), body.get_global_position())
			if manager.maximo_valas_por_disparo == i:
				break
			i += 1
