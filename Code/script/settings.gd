extends VBoxContainer


func _ready():
	var config = ConfigFile.new()
	config.load("user://settings.cfg")
	
	if config.get_value("settings", "inverse_controls") == true:
		get_node("Inverse Controls").set_pressed(true)
	else:
		get_node("Inverse Controls").set_pressed(false)
		
	if config.get_value("settings", "mute_music") == true:
		get_node("Mute Music").set_pressed(true)
	else:
		get_node("Mute Music").set_pressed(false)
		
	if config.get_value("settings", "mute_sound_effects") == true:
		get_node("Mute Sound Effects").set_pressed(true)
	else:
		get_node("Mute Sound Effects").set_pressed(false)
		
	if config.get_value("settings", "online_ranking") == true:
		get_node("Online Ranking").set_pressed(true)
	else:
		get_node("Online Ranking").set_pressed(false)
		
	if config.get_value("settings", "updates_from_developers") == true:
		get_node("Updates from Developers").set_pressed(true)
	else:
		get_node("Updates from Developers").set_pressed(false)
		
	if config.get_value("settings", "log_files") == true:
		get_node("Log Files").set_pressed(true)
	else:
		get_node("Log Files").set_pressed(false)
		
	if config. has_section_key("settings", "volume") == true:
		var value = config.get_value("settings", "volume")
		get_node("VolumeControl/Volume").set_value(value)
	else:
		get_node("VolumeControl/Volume").set_value(50)

func _on_Back_pressed():
	var config = ConfigFile.new()
	config.load("user://settings.cfg")
	config.set_value("settings", "inverse_controls", get_node("Inverse Controls").is_pressed())
	config.set_value("settings", "mute_music", get_node("Mute Music").is_pressed())
	config.set_value("settings", "mute_sound_effects", get_node("Mute Sound Effects").is_pressed())
	config.set_value("settings", "updates_from_developers", get_node("Updates from Developers").is_pressed())
	config.set_value("settings", "log_files", get_node("Log Files").is_pressed())
	config.set_value("settings", "volume", get_node("VolumeControl/Volume").get_value())
	config.save("user://settings.cfg")

func _on_Reset_Game_pressed():
	get_node("/root/Autoplay/AudioStreamPlayer")._set_playing(false)
	var dir = Directory.new()
	dir.remove("user://settings.cfg")
	get_tree().change_scene("res://scenes/boot.tscn")
	

func _on_Terms_and_Conditions_pressed():
	get_node("../../../Terms and Conditions").show()

func _on_Ok_pressed():
	get_node("../../../Terms and Conditions").hide()
	get_node("../../../About").hide()

func _on_About_pressed():
	get_node("../../../About").show()
