class_name VirtualSceneTest
extends VirtualScene

@export var texture: Texture2D

func _ready():
	for i in range(200):
		var enemy = BasicEnemy.new($FakePlayer, self.texture, 100.0, Vector2(100, 100) * i, 200, 100.0, Rect2(0, 0, 200, 200), 0.0, ["enemies"])
		self.add_virtual_child(enemy)
	
	var player_collider = VirtualPlayerCollider.new($FakePlayer)
	self.add_virtual_child(player_collider)
