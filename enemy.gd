extends CharacterBody2D

@export var speed = 1500

var ghost_scene = preload("res://ghost.tscn")

var points = []
var tarjet: Node2D = null
var tarjet_index = 0

var _velocity: Vector2 = Vector2.ZERO

var is_persecution = false

var timer_started = false

var on_damage = false

func _ready():
	if has_node("path"):
		for point in get_node("path").get_children():
			points.append(point)
	
	if points.size() > 0:
		tarjet = points[0]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if tarjet != null:
		if on_damage:
			_velocity = position.direction_to(tarjet.position) * (speed / 2)
		else:
			_velocity = position.direction_to(tarjet.position) * speed

	if tarjet != null:
		if is_persecution == false:
			if position.distance_to(tarjet.position) > 100:
				velocity = _velocity
			else:
				if tarjet_index < (points.size() - 1):
					tarjet_index += 1
					tarjet = points[tarjet_index]
				else:
					tarjet = points[0]
					tarjet_index = 0
		else:
			if position.distance_to(tarjet.position) > 300:
				velocity = _velocity
	
	$Sprite2D.flip_h = velocity.x <= -1
	
	if $Sprite2D.flip_h:
		$Weapon.scale.x = -1
	else:
		$Weapon.scale.x = 1
	
	if is_persecution and timer_started == false:
		timer_started = true
		$Timer.start()
	
	move_and_slide()


func _on_player_detector_area_entered(area):
	if area.is_in_group("players"):
		tarjet = area
		is_persecution = true



func _on_player_detector_area_exited(area):
	if area.is_in_group("players"):
		if points.size() > 0:
			tarjet = points[tarjet_index]
		is_persecution = false


func _on_visible_on_screen_notifier_2d_screen_entered():
	set_process(true)


func _on_visible_on_screen_notifier_2d_screen_exited():
	set_process(false)


func _on_timer_timeout():
	timer_started = false
	
	$Weapon.fire(get_parent())


func _on_damage_zone_area_entered(area):
	if area.is_in_group("player_bullets"):
		#lo siguiente es temporal. Recordar poner un indicador de vida, retrazo en el movimiento y animacion de muerte
		$EnemyHealthBar.set_damage()
		on_damage = true
		$OnDamageTimer.start()
		$Sprite2D.modulate = Color.RED
		if $EnemyHealthBar.value <= 0:
			var manager = get_node("/root/GameManager")
			if manager.ghost_count < manager.MAX_GHOST_COUNT:
				manager.ghost_count += 1
				var ghost_intance = ghost_scene.instantiate()
				ghost_intance.transform = get_global_transform()
				ghost_intance.position = self.position
				get_parent().add_child(ghost_intance)
				print(manager.ghost_count)
				print(manager.MAX_GHOST_COUNT)
				print(manager.ghost_count <= manager.MAX_GHOST_COUNT)
			
			manager.enemy_count -= 1
			manager.enemies_elimitated += 1
			queue_free()


func _on_on_damage_timer_timeout():
	on_damage = false
	$Sprite2D.modulate = Color.WHITE
