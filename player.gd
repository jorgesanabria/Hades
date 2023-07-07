extends Area2D

@export var speed = 1500

@export var health_bar_path: NodePath

var ghost_list = []
var firts_ghost: Area2D = null

var is_flip_h = false

func _ready():
	self.ghost_list.append(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var input_direction = Input.get_vector("left", "right", "up", "down")
	position += input_direction * speed * delta
	
	if Input.is_action_pressed("right"):
		is_flip_h = true
	
	if Input.is_action_pressed("left"):
		is_flip_h = false
	
	$Sprite2D.flip_h = is_flip_h
	
	if $Sprite2D.flip_h:
		$Weapon.scale.x = -1
	else :
		$Weapon.scale.x = 1
	
	for area in $GhostDetector.get_overlapping_areas():
		process_entered(area)
	
	if Input.is_action_just_pressed("fire"):
		$Weapon.fire(get_parent())

func process_entered(area):
	if area.is_in_group("ghosts") == false:
		return
		
	if ghost_list.has(area):
		return
		
	var last = ghost_list[-1]
	area.set_tarjet(last)
		
	ghost_list.append(area)

func take_damage():
	$Sprite2D.modulate = Color.RED
	$DamageTimer.start()
	if health_bar_path != null and has_node(health_bar_path):
		get_node(health_bar_path).value -= 10


func _on_damage_timer_timeout():
	$Sprite2D.modulate = Color.WHITE


func _on_enemy_spawner_timer_timeout():
	$Spawner.spawn_enemy(get_parent())
	calculateAndStartGenerationTimer()

func calculateGenerationSpeed() -> float:
	var averageEnemiesEliminated: int = 12
	var speedMultiplier: float = 1.0

	var manager = get_node("/root/GameManager")
	if get_node(health_bar_path).value < 30 and manager.enemies_elimitated < averageEnemiesEliminated:
		speedMultiplier = 0.5  # Reducir la velocidad a la mitad si la vida del jugador es baja y se eliminaron pocos enemigos
	elif get_node(health_bar_path).value > 70 and manager.enemies_elimitated > averageEnemiesEliminated:
		speedMultiplier = 1.5  # Aumentar la velocidad en un 50% si la vida del jugador es alta y se eliminaron muchos enemigos

	var generationSpeed: float = speedMultiplier * averageEnemiesEliminated
	
	manager.enemies_elimitated = 0
	
	return generationSpeed

func calculateAndStartGenerationTimer() -> void:
	var generationSpeed: float = calculateGenerationSpeed()

	# Detener y reiniciar el temporizador con la duración calculada
	$EnemySpawnerTimer.stop()
	$EnemySpawnerTimer.wait_time = 10.0 / generationSpeed
	$EnemySpawnerTimer.start()
	
