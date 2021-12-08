extends TouchScreenButton

var dead = false

func _process(delta):
	if(get_tree().paused and dead==false):
		visible = true
	else:
		visible = false

func _on_play_pressed():
	get_tree().set_pause(false)

func _on_Player_dead():
	dead = true
	visible = false
	
