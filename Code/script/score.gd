extends Label

signal scoreUpdate
signal level

var score = 0
var position = 0
var oldPos
var maximum = 2147483647 #Might have to find the maximum value allowed by GDscript 
var powerup = 50
var nextLevel = 2

func _physics_process(delta):
	position = get_tree().get_root().get_node("Node/Player").get_global_position()
	if (int(position.x) !=oldPos):
		oldPos = int(position.x)
		if score <= maximum:
			score += 1
	
	if score > maximum:
		score = maximum
	
	text = "Score: " + str(score) 
	
	if score >= 10000 && nextLevel == 2:
		nextLevel += 1
		emit_signal("level", 2)
	if score >= 20000 && nextLevel == 3:
		nextLevel += 1
		emit_signal("level", 3)
		
		
	if(get_tree().paused):
		visible = false
	else:
		visible = true
		emit_signal("scoreUpdate", score)
	
func get_value(data):
	if score <= maximum:
		score += data
	
func get_powerup(data):
	if score <= maximum:
		score += powerup
