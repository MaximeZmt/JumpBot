extends Button

func _ready():
	var config = ConfigFile.new()
	config.load("user://settings.cfg")
	if config.has_section_key("settings", "username"):
		if config.has_section_key("settings", "password"):
			self.set_text("CHANGE ACCOUNT")
		else:
			self.set_text("CONNECT ACCOUNT")
	else:
		self.set_text("CONNECT ACCOUNT")