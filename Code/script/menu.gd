extends VBoxContainer

#var AdMob = null
var adShown = false

func _ready():
	get_tree().set_pause(false)
	
	#if(Engine.has_singleton("AdMob") && adShown == false):
	#	AdMob = Engine.get_singleton("AdMob")
	#	AdMob.init(true, get_instance_id())
	#	AdMob.loadInterstitial("?????")
		
	var config = ConfigFile.new()
	config.load("user://settings.cfg")
	if config.has_section_key("settings", "username"):
		if config.has_section_key("settings", "password"):
			get_node("subMenu/play/OnlineMode").show()
			get_node("subMenu/play/User").show()
			get_node("subMenu/play/User").set_text("Playing as: \n" + String(config.get_value("settings", "username")))
			if config.get_value("settings", "play_online") == true:
				get_node("subMenu/play/OnlineMode").set_pressed(true)
			else:
				get_node("subMenu/play/OnlineMode").set_pressed(false)
		else:
			get_node("subMenu/play/OnlineMode").hide()
			get_node("subMenu/play/User").hide()
	else:
		get_node("subMenu/play/User").hide()
		get_node("subMenu/play/OnlineMode").hide()

#func _on_interstitial_loaded():
#	if (adShown == false):
#		AdMob.showInterstitial()
#		print("Ad Has Been Shown")
#		adShown = true

func _on_Play_pressed():
	get_node("../GameLoading").show()
	yield(get_tree().create_timer(0.1), "timeout")
	get_tree().change_scene("res://scenes/level.tscn")
	

func _on_Settings_pressed():
	get_tree().change_scene("res://scenes/settings.tscn")


func _on_Scores_pressed():
	get_tree().change_scene("res://scenes/scores.tscn")


func _on_OnlineMode_pressed():
	var config = ConfigFile.new()
	config.load("user://settings.cfg")
	
	if get_node("subMenu/play/OnlineMode").is_pressed():
		config.set_value("settings", "play_online", true)
		config.save("user://settings.cfg")
	else:
		config.set_value("settings", "play_online", false)
		config.save("user://settings.cfg")
