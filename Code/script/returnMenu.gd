extends TextureButton

func _on_Back_pressed():
	get_node("../MenuLoading").show()
	yield(get_tree().create_timer(0.1), "timeout")
	get_tree().change_scene("res://scenes/menu.tscn")
