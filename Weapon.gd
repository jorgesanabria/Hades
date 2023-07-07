extends Marker2D

var bullet_scene = preload("res://enemy_bullet.tscn")

func fire(map: Node2D):
	for direction in get_children():
		var bullet_instance = bullet_scene.instantiate()
		bullet_instance.transform = direction.get_global_transform()
		map.add_child(bullet_instance)
		bullet_instance.set_direction(get_global_position(), direction.get_global_position())
