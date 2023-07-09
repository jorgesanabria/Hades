extends Label

var manager:Node = null

# Called when the node enters the scene tree for the first time.
func _ready():
	manager = get_node("/root/GameManager")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = str(manager.indice_oleada)
