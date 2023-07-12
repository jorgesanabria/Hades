class_name BaseVirtualNode

extends Object

var position: Vector2
var speed: float
var radius: float
var rect: Rect2
var rotation: float
var groups: Array[String]

func _init(position: Vector2, speed: float, radius: float, rect: Rect2, rotation: float = 0.0, groups: Array[String] = []):
	self.position = position
	self.speed = speed
	self.radius = radius
	self.rect = rect
	self.rotation = rotation
	self.groups = groups

func update(delta: float, scene: VirtualScene):
	pass

func fix_distance(other: BaseVirtualNode, scene: VirtualScene):
	var distance = other.position.distance_to(self.position)
	if (other.radius + self.radius) >= distance:
		if !self.determinate_if_colliding(other, scene):
			return
			
		var separation = (other.radius + self.radius - distance) / 2.0
		var direction = (other.position - self.position).normalized()
		var translation = direction * separation
		self.position -= translation
		other.position += translation

func get_current_texture() -> Texture2D:
	return null

func draw(tarject: Node2D):
	var current_texture = get_current_texture()
	if current_texture == null:
		#print("La textura actual es nula. Se ignorara la operacion")
		return
		
	tarject.draw_set_transform(position, self.rotation)
	tarject.draw_texture_rect(current_texture, self.rect, false)
	tarject.draw_set_transform(Vector2.ZERO, 0)

func determinate_if_colliding(other: BaseVirtualNode, scene: VirtualScene) -> bool:
	return true
