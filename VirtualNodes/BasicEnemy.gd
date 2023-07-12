class_name BasicEnemy
extends BaseVirtualNode

var tarjet: Node2D
var texture: Texture2D
var health: float

func _init(tarjet: Node2D, texture: Texture2D, health: float, position: Vector2, speed: float, radius: float, rect: Rect2, rotation: float = 0.0, collision_groups: Array[String] = []):
	super._init(position, speed, radius, rect, rotation, collision_groups)
	self.tarjet = tarjet
	self.texture = texture
	self.health = health

func update(delta: float, scene: VirtualScene):
	if position.distance_to(tarjet.position) >= 5:
		position += position.direction_to(tarjet.position) * speed * delta

func get_current_texture() -> Texture2D:
	return self.texture

func is_alive() -> bool:
	return self.health > 0.0

func determinate_if_colliding(other: BaseVirtualNode, scene: VirtualScene):
	if "players" in other.groups:
		scene.queue_remove_virtual_child(self)
	return true
