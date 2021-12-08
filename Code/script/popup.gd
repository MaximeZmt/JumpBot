extends ColorRect

func _on_Skip_pressed():
	self.hide()
	get_tree().paused = false


func _on_Log_In_pressed():
	get_node("../logIn").show()
	self.hide()

func _on_Sign_Up_pressed():
	get_node("../signUp").show()
	self.hide()

func _on_Skip_login_pressed():
	get_node("../logIn").hide()	
	get_node("../logIn/VBoxContainer/HBoxContainer/Input/Username").clear()
	get_node("../logIn/VBoxContainer/HBoxContainer/Input/Password").clear()
	self.show()

func _on_Skip_signUp_pressed():
	get_node("../signUp").hide()
	get_node("../signUp/VBoxContainer/HBoxContainer/Input/Username").clear()
	get_node("../signUp/VBoxContainer/HBoxContainer/Input/Password").clear()
	get_node("../signUp/VBoxContainer/HBoxContainer/Input/Confirm Password").clear()
	self.show()

func _on_Ok_pressed():
	get_node("../Terms and Conditions").hide()
	get_node("../developerUpdate").hide()
