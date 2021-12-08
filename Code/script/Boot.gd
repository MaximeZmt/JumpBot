extends Node

func _ready():
	#var dir = Directory.new() #Enable this if you want to clear directory
	#dir.remove("user://settings.cfg")
	get_tree().set_quit_on_go_back(false)
	yield(get_tree().create_timer(2), "timeout")
	get_tree().change_scene("res://scenes/menu.tscn")
	
func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST: 
		get_tree().quit()
