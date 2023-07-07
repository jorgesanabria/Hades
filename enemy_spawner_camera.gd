extends Camera2D

@export var map_path: NodePath

var enemy_scene = preload("res://enemy.tscn")

func _on_spawner_timer_timeout():
	var manager = get_node("/root/GameManager")
	if manager.enemy_count >= manager.MAX_ENEMY_COUNT:
		return
	else:
		manager.enemy_count += 1
	var _rect = self.get_viewport_rect()
	_rect.get_area()
	var rect = self.get_viewport_rect().size
	print(rect)
	var camera_size = rect * 1.5
	var random_border = randi_range(0, 3)
	var random_point = Vector2()

	if random_border == 0:  # Borde superior
		random_point.x = randi_range(0, camera_size.x)
		random_point.y = 0
	elif random_border == 1:  # Borde derecho
		random_point.x = camera_size.x
		random_point.y = randi_range(0, camera_size.y)
	elif random_border == 2:  # Borde inferior
		random_point.x = randi_range(0, camera_size.x)
		random_point.y = camera_size.y
	else:  # Borde izquierdo
		random_point.x = 0
		random_point.y = randi_range(0, camera_size.y)
	
	assert(has_node(map_path), "Debe definir un path de nodo de escena")
	
	var enemy_instance = enemy_scene.instantiate()
	enemy_instance.transform = get_global_transform()
	enemy_instance.position = random_point
	
	get_node(map_path).add_child(enemy_instance)
	
