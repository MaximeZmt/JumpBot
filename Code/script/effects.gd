extends AudioStreamPlayer

var powerup = "res://sounds/powerup.wav"
var coin = "res://sounds/coin.wav"
var sfx1
var sfx2

func _ready(): 
	sfx1 = load(coin)
	sfx2 = load(powerup)

func get_powerup(data):
	self.stop()
	self.stream = sfx1
	self.play(0)
	
func get_value(data):
	self.stop()
	self.stream = sfx2
	self.play(0)