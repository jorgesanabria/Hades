extends TextureProgressBar

func set_damage():
	self.visible = true
	self.value -= 100
	$Timer.start()


func _on_timer_timeout():
	self.visible = false
