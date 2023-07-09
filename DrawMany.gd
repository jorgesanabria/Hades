extends Node2D

class EnemyData extends Resource:

	var position: Vector2
	var speed = 0
	var positions = []
	var tarjet: Vector2
	var current_tarjet_index = 0
	var radius = 50

	func _init(position: Vector2, speed: float, positions, radius: float):
		self.position = position
		self.speed = speed
		self.positions = positions
		self.tarjet = self.positions[0]
		self.radius = radius
	
	func update(delta: float):
		if position.distance_to(tarjet) >= 5:
			position += position.direction_to(tarjet) * speed * delta
			#print("menor o igual a 10")
		else:
			if current_tarjet_index < (positions.size() - 1):
				current_tarjet_index += 1
				tarjet = positions[current_tarjet_index]
				print("menor que size")
			else:
				tarjet = positions[0]
				current_tarjet_index = 0
	func fix_distance(other: EnemyData):
		var distance = other.position.distance_to(self.position)
		if (other.radius + self.radius) >= distance:
			var separation = (other.radius + self.radius - distance) / 2.0
			var direction = (other.position - self.position).normalized()
			var translation = direction * separation
			self.position -= translation
			other.position += translation

@export var texture: Texture2D

var enemies = []

var positions = []

var max_objects = 50

# Called when the node enters the scene tree for the first time.
func _ready():
	for marker in get_children().filter(func(item): return !item.is_in_group("timer")):
		positions.append(marker.position)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for enemy in enemies:
		enemy.update(delta)
	var i = 0;
	while i < enemies.size():
		var j = i + 1
		print("i: " + str(i))
		while j < enemies.size():
			print("j: " + str(j))
			enemies[i].fix_distance(enemies[j])
			j += 1
		i += 1
	queue_redraw()

func _draw():
	#draw_texture(texture, Vector2(100, 100))
	#draw_texture_rect(texture, Rect2(100, 100, 100, 100), false)
	for enemy in enemies:
		draw_texture_rect(texture, Rect2(enemy.position.x, enemy.position.y, 100, 100), false)

func _on_timer_timeout():
	var enemy = EnemyData.new(Vector2.ZERO, 200, positions, 50)
	enemies.append(enemy)
