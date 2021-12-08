extends TouchScreenButton

func _process(delta):
	if(get_tree().paused):
		visible = false
	else:
		visible = true

func _on_pause_pressed():
	get_tree().set_pause(true)
