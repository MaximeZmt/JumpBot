extends Label

func _ready():
	var config = ConfigFile.new()
	config.load("user://settings.cfg")
	var score = config.get_value("settings", "highscore")
	self.set_text("Local Score: " + String(score))
