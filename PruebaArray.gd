extends Node2D


@export var datos: Array[Sprite2D] = []

@export var t: Texture2D

# Called when the node enters the scene tree for the first time.
func _ready():
	for item in datos:
		print(item)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
