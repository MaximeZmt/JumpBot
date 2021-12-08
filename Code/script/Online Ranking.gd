extends CheckButton

func _ready():
	var config = ConfigFile.new()
	config.load("user://settings.cfg")
	if config.has_section_key("settings", "username"):
		if config.has_section_key("settings", "password"):
			self.show()
			get_node("../Separator5").show()
		else:
			self.hide()
			get_node("../Separator5").hide()
	else:
		self.hide()
		get_node("../Separator5").hide()