extends Node

var firstRun = true
var config

signal login
signal signUp
signal message

func _ready():
	get_tree().set_quit_on_go_back(false)
	config = ConfigFile.new()
	var err = config.load("user://settings.cfg")
	if err == OK:
		firstRun = false
		devMessage()
	else:
		firstRun = true
		get_node("Terms and Conditions").show()
	runTest()

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST: 
		get_tree().quit()
	
func devMessage():
	var isActive = config.get_value("settings", "updates_from_developers")
	var number = config.get_value("settings", "updates_from_developers_number")
	
	if isActive == true:
		emit_signal("message", number)
	
func runTest():
	if firstRun == true:
		get_node("/root/Autoplay/AudioStreamPlayer")._set_playing(true)
		get_tree().paused = true
		get_node("popup").show()
		config.set_value("settings", "inverse_controls", false)
		config.set_value("settings", "mute_music", false)
		config.set_value("settings", "mute_sound_effects", false)
		config.set_value("settings", "online_ranking", true)
		config.set_value("settings", "updates_from_developers_number", 0)
		config.set_value("settings", "updates_from_developers", true)
		config.set_value("settings", "log_files", false)
		config.set_value("settings", "volume", 0) #Middle is 0, 10 is max, -10 is min
		config.set_value("settings", "highscore", 0)
		config.set_value("settings", "play_online", false)
		config.save("user://settings.cfg")
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), false)
		print("App was not previously run")
	else:
		print("App was already run")

func _on_Enter_login_pressed():
	var username = get_node("logIn/VBoxContainer/HBoxContainer/Input/Username").get_text()
	var password = get_node("logIn/VBoxContainer/HBoxContainer/Input/Password").get_text()
	
	if username.length() <= 24 and username.length() >= 1:
		if password.length() <= 24 and password.length() >= 1:
			if username.findn(" ") == -1:
				if password.findn(" ") == -1:
					password = password.sha256_text()
					emit_signal("login", username, password)
					firstRun = false

func _on_Enter_signUp_pressed():
	var username = get_node("signUp/VBoxContainer/HBoxContainer/Input/Username").get_text()
	var password = get_node("signUp/VBoxContainer/HBoxContainer/Input/Password").get_text()
	var passwordConfirm = get_node("signUp/VBoxContainer/HBoxContainer/Input/Confirm Password").get_text()
	
	if password == passwordConfirm:
		if username.length() <= 24 and username.length() >= 4:
			if password.length() <= 24 and password.length() >= 4:
				if username.findn(" ") == -1:
					if password.findn(" ") == -1:
						password = password.sha256_text()
						emit_signal("signUp", username, password)
						firstRun = false
