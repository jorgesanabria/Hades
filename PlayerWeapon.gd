extends Marker2D

var bullet_scene = preload("res://player_bullet.tscn")

func fire(map):
	for body in $EnemyDetector.get_overlapping_bodies().filter(func(item): return item.is_in_group("enemies")):
		for start_point in get_children().filter(func(item): return item.is_in_group("fireflies")):
			var bullet_instance = bullet_scene.instantiate()
			bullet_instance.transform = start_point.get_global_transform()
			map.add_child(bullet_instance)
			bullet_instance.set_direction(start_point.get_global_position(), body.get_global_position())
