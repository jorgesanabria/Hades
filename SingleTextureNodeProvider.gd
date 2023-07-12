extends Node

@export var texture: Texture2D

func get_instance() -> BasicEnemy:
	return BasicEnemy.new(Vector2(500, 500), self.texture, 100.0, Vector2.ZERO, 200.0, 50.0, Rect2(0, 0, 100, 100))
