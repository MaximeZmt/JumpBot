extends Node

func _ready():
	var directory = Directory.new();
	var doFileExists = directory.file_exists("user://settings.cfg")
	
	if doFileExists == true:
		var config = ConfigFile.new()
		config.load("user://settings.cfg")
		
		if config.has_section_key("settings", "username") == false:
			config.set_value("settings", "play_online", false)
			config.save("user://settings.cfg")
		elif config.has_section_key("settings", "password") == false:
			config.set_value("settings", "play_online", false)
			config.save("user://settings.cfg")
	
		if config.get_value("settings", "mute_music") == true:
			if get_node("/root/Autoplay/AudioStreamPlayer").is_playing() == true:
				AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), true)
				get_node("/root/Autoplay/AudioStreamPlayer")._set_playing(false)
		else:
			if get_node("/root/Autoplay/AudioStreamPlayer").is_playing() == false:
				AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"), false)
				get_node("/root/Autoplay/AudioStreamPlayer")._set_playing(true)
		
		if config.get_value("settings", "mute_sound_effects") == true:
			AudioServer.set_bus_mute(AudioServer.get_bus_index("Jump"), true)
			AudioServer.set_bus_mute(AudioServer.get_bus_index("Effects"), true)
		else:
			AudioServer.set_bus_mute(AudioServer.get_bus_index("Jump"), false)
			AudioServer.set_bus_mute(AudioServer.get_bus_index("Effects"), false)
		
		if config.get_value("settings", "log_files") == true:
			ProjectSettings.set("logging/file_logging", true)
		else:
			ProjectSettings.set("logging/file_logging", false)
		
		if config.has_section_key("settings", "volume") == true:
			var volume = config.get_value("settings", "volume")
			
			if volume > 10:
				volume = 10
				
			if volume < -10:
				volume = -10
				
			if volume == -10:
				AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), true)
			else:
				AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), false)
			
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), volume)
			 #Max 24 (make it 20), min -80 let's make the middle groud at -10
	
	
			#config.get_value("settings", "updates_from_developers") NEED TO BE ADDED

	
	
