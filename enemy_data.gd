class EnemyData extends Resource:

	var position: Vector2
	var speed = 0
	var positions = []
	var tarjet: Vector2
	var current_tarjet_index = 0

	func _init(position: Vector2, speed: float, positions):
		self.position = position
		self.speed = speed
		self.positions = positions
		self.tarjet = self.positions[0]
	
	func move_to(delta: float):
		if position.distance_to(tarjet) >= 10:
			position += (tarjet - position).normalized() * speed * delta
		else:
			if current_tarjet_index < (positions.size() - 1):
				current_tarjet_index += 1
				tarjet = positions[current_tarjet_index]
			else:
				tarjet = positions[0]
				current_tarjet_index = 0
