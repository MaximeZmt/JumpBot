extends Label

var highscore = -1
var score = 0
var newHighscore = false
var isConnected
var onlineMode = false

signal highscoreUpdate
signal setHighscore
signal getHighscore
signal continueFunction

func _ready():
	var config = ConfigFile.new()
	config.load("user://settings.cfg")
	get_tree().paused = true
	onlineMode = config.get_value("settings", "play_online")
	
	if onlineMode == true:
		get_node("../../FullScreens/LoadingScreen").show()
		yield(get_tree().create_timer(0.1), "timeout")
		emit_signal("getHighscore")
		if highscore == -1:
			isConnected = false
			highscore = config.get_value("settings", "highscore")
			get_node("../mode").set_text("Mode: Offline")
		else:
			isConnected = true
			get_node("../mode").set_text("Mode: Online")
	else:
		isConnected = false
		highscore = config.get_value("settings", "highscore")
		get_node("../mode").set_text("Mode: Offline")
	get_tree().paused = false

func _physics_process(delta):
	if(get_tree().paused):
		visible = false
	else:
		visible = true
		emit_signal("highscoreUpdate", highscore, newHighscore)

func _on_Update(data):
	if highscore != -1:
		score = data
		
		if (score > highscore and newHighscore == false):
			newHighscore = true
			text = "Highscore: " + "NEW HIGHSCORE!"
		elif newHighscore == false:
			text = "Highscore: " + str(highscore)


func _on_Player_dead():
	if newHighscore == true and isConnected == true and onlineMode == true:
		if score > highscore:
			var config = ConfigFile.new()
			get_node("../../FullScreens/UploadScreen").show()
			yield(get_tree().create_timer(0.1), "timeout")
			emit_signal("setHighscore", score)
			if config.has_section_key("settings", "highscore"):
				if score > config.get_value("settings", "highscore"):
					config.set_value("settings", "highscore", score)
					config.save("user://settings.cfg")
	if newHighscore:
		if score > highscore:
			var config = ConfigFile.new()
			config.load("user://settings.cfg")
			if score > config.get_value("settings", "highscore"):
				config.set_value("settings", "highscore", score)
				config.save("user://settings.cfg")
				
	emit_signal("continueFunction")
