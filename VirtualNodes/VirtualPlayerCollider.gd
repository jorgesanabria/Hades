class_name VirtualPlayerCollider
extends BaseVirtualNode

var player: Node2D

func _init(player: Node2D):
	super._init(player.position, 400.0, 200.0, Rect2(0, 0, 0, 0), 0.0, ["players"])
	self.player = player

func update(delta: float, scene: VirtualScene):
	self.position = self.player.position - Vector2(100, 100)
