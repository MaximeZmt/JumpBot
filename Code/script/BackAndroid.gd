extends Node

signal back

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		if (get_tree().paused == false):
			get_tree().paused = true
		else:
			emit_signal("back")
		yield(get_tree().create_timer(3), "timeout")