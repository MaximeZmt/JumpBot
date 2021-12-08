extends AudioStreamPlayer

var jump = "res://sounds/jump.wav"
var sfx

func _ready():
	sfx = load(jump)

func _on_jump():
	self.stop()
	self.stream = sfx
	self.play(0)