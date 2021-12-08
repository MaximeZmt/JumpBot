extends Label

signal login
signal signUp
signal changePassword
signal deleteAccount

func _on_Disconnect_pressed():
	var config = ConfigFile.new()
	config.load("user://settings.cfg")
	config.set_value("settings", "username", null)
	config.set_value("settings", "password", null)
	config.save("user://settings.cfg")
	get_node("../More").hide()
	get_node("../Options/ChangeAccount").set_text("CONNECT ACCOUNT")
	get_node("../Options").show()
	get_node("../Options/More").hide()
	get_node("../Reset Online Score").hide()
	get_node("../Reset Online Score Result").hide()
	get_node("../Options/ChangePassword").hide()
	get_node("../Separator11").hide()
	get_node("../Online Ranking").hide()
	get_node("../Online Ranking Result").hide()
	get_node("../Separator5").hide()

func _on_Change_Account_pressed():
	get_node("../Options").hide()
	get_node("../ChangingAccount").show()


func _on_Cancel_pressed():
	get_node("../ChangingAccount").hide()
	get_node("../loginForm").hide()
	get_node("../signUpForm").hide()
	get_node("../changePassword").hide()
	get_node("../Options").show()
	get_node("../loginForm/Username").clear()
	get_node("../loginForm/Password").clear()
	get_node("../signUpForm/Username").clear()
	get_node("../signUpForm/Password").clear()
	get_node("../signUpForm/Confirm Password").clear()
	get_node("../changePassword/Old Password").clear()
	get_node("../changePassword/New Password").clear()
	get_node("../changePassword/New Password Check").clear()
	get_node("../loginForm/Result").hide()
	get_node("../signUpForm/Result").hide()
	get_node("../changePassword/Result").hide()
	

func _on_LogIn_pressed():
	get_node("../ChangingAccount").hide()
	get_node("../loginForm").show()

func _on_SignUp_pressed():
	get_node("../ChangingAccount").hide()
	get_node("../signUpForm").show()
	
func _on_ChangePassword_pressed():
	get_node("../Options").hide()
	get_node("../changePassword").show()
	
func _on_More_pressed():
	get_node("../Options").hide()
	get_node("../More").show()
	get_node("../More/Disconnect").show()
	get_node("../More/Delete Account").show()
	get_node("../More/Back").show()
	
func _on_Back_pressed():
	get_node("../More").hide()
	get_node("../Options").show()
	

func _on_Delete_Account_pressed():
	get_node("../More").hide()
	get_node("../deleteAccount").show()
	
func _on_No_pressed():
	get_node("../More").show()
	get_node("../deleteAccount").hide()

func _on_Yes_pressed():
	var config = ConfigFile.new()
	config.load("user://settings.cfg")
	var username = config.get_value("settings", "username")
	var password = config.get_value("settings", "password")
	emit_signal("deleteAccount", username, password)

func _on_Enter_login_pressed():
	var username = get_node("../loginForm/Username").get_text()
	var password = get_node("../loginForm/Password").get_text()
	
	if username.length() <= 24 and username.length() >= 1:
		if password.length() <= 24 and password.length() >= 1:
			if username.findn(" ") == -1:
				if password.findn(" ") == -1:
					password = password.sha256_text()
					emit_signal("login", username, password)

func _on_Enter_signUp_pressed():
	var username = get_node("../signUpForm/Username").get_text()
	var password = get_node("../signUpForm/Password").get_text()
	var passwordConfirm = get_node("../signUpForm/Confirm Password").get_text()
	
	if password == passwordConfirm:
		if username.length() <= 24 and username.length() >= 4:
			if password.length() <= 24 and password.length() >= 4:
				if username.findn(" ") == -1:
					if password.findn(" ") == -1:
						password = password.sha256_text()
						emit_signal("signUp", username, password)

func _on_Enter_changePassword_pressed():
	var oldPassword = get_node("../changePassword/Old Password").get_text()
	var newPassword = get_node("../changePassword/New Password").get_text()
	var newPasswordConfirm = get_node("../changePassword/New Password Check").get_text()
	
	var config = ConfigFile.new()
	config.load("user://settings.cfg")
	var username = config.get_value("settings", "username")
	var storedPassword = config.get_value("settings", "password")
	
	

	if oldPassword.length() <= 24 and oldPassword.length() >= 1:
		if oldPassword.findn(" ") == -1:
			oldPassword = oldPassword.sha256_text()
			if oldPassword == storedPassword:
				if newPassword == newPasswordConfirm:
					if username.length() <= 24 and username.length() >= 1:
						if newPassword.length() <= 24 and newPassword.length() >= 1:
							if username.findn(" ") == -1:
								if newPassword.findn(" ") == -1:
									newPassword = newPassword.sha256_text()
									emit_signal("changePassword", username, oldPassword, newPassword)
