extends TouchScreenButton

signal powerup
var blink = false
var timer = 0
export var powerup = 0

func _ready():
	var config = ConfigFile.new()
	config.load("user://settings.cfg")
	var inverse = config.get_value("settings", "inverse_controls")
	var default = Vector2(0,0)
	default = self.get_global_position()
	
	if inverse == true: #930
		self.set_global_position(Vector2(930, default.y))
	else: #10
		self.set_global_position(Vector2(10, default.y))
	
func _on_pressed():
	get_node("../jumpButton").hide()
	if blink == false:
		self.hide()
		emit_signal("powerup", powerup)
		print("Signal Sent: " + str(powerup))
	if powerup == 1 or powerup == 2 or powerup == 3:
		blink = true
	get_node("../jumpButton").show()

func _physics_process(delta):
	if timer == 30 and blink == true:
		if self.is_visible() == false:
			self.show()
		else:
			self.hide()
		
		timer = 0
	
	if blink == true:
		timer += 1
	else:
		timer = 0
		


func _on_powerup_over(powerup2):
	if powerup2 != 0:
		blink = false
		if powerup2 == 1:
			get_node("/root/Node/CanvasLayer/inverse_direction").hide()
		elif powerup2 == 2:
			get_node("/root/Node/CanvasLayer/jump_increase").hide()
		elif powerup2 == 3:
			get_node("/root/Node/CanvasLayer/speed_increase").hide()
