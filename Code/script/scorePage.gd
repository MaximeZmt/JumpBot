extends VBoxContainer

signal getScore

func _ready():
	var config = ConfigFile.new()
	config.load("user://settings.cfg")
	if config.get_value("settings", "online_ranking") == true:
		if config.has_section_key("settings", "username"):
			if config.has_section_key("settings", "password"):
				var username = config.get_value("settings", "username")
				emit_signal("getScore", username)
			else:
				hidden()
		else:
			hidden()
	else:
		hidden()
		
func hidden():
	get_node("Subtitle").hide()
	get_node("Separator2").hide()
	get_node("Online").hide()
	get_node("search").hide()
	get_node("Selected Player").hide()
	get_node("Online Score").hide()
	get_node("Top10").hide()
	get_node("Top Container").hide()
	get_node("After10").hide()
	get_node("After Container").hide()
	get_node("Before10").hide()
	get_node("Before Container").hide()
		
