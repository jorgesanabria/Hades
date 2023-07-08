extends Marker2D

var enemy_scene = preload("res://enemy.tscn")

func _ready():
	randomize()

func spawn_enemy(map):
	var manager = get_node("/root/GameManager")
	if manager.enemy_count >= manager.MAX_ENEMY_COUNT:
		return
	else:
		manager.enemy_count += 1
	var random_childIndex = randi() % get_child_count()
	var random_child_node = get_child(random_childIndex)
	var enemy_instance = enemy_scene.instantiate()
	enemy_instance.transform = get_global_transform()
	enemy_instance.position = random_child_node.position
	map.add_child(enemy_instance)

func spawn_range(map):
	var manager = get_node("/root/GameManager")
	for i in range(0, manager.enemigos_cada_3_segundos):
		var random_childIndex = randi() % get_child_count()
		var random_child_node = get_child(random_childIndex)
		var enemy_instance = enemy_scene.instantiate()
		enemy_instance.transform = get_global_transform()
		enemy_instance.position = random_child_node.position
		map.add_child(enemy_instance)
	
	manager.enemigos_en_la_oleada += manager.enemigos_cada_3_segundos
