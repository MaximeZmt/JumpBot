extends Button

func _ready():
	var config = ConfigFile.new()
	config.load("user://settings.cfg")
	if config.has_section_key("settings", "username"):
		if config.has_section_key("settings", "password"):
			self.show()
		else:
			self.hide()
	else:
		self.hide()

