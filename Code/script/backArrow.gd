extends Node

signal back

func _ready():
	get_tree().set_quit_on_go_back(false)
	
func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST: 
		emit_signal("back")
