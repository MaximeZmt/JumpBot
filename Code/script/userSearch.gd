extends HBoxContainer

signal getScore

func _on_Enter_pressed():
	var username = get_node("Searchbar").get_text()
	print(username)
	emit_signal("getScore", username)
