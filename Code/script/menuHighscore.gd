extends Label

var highscore = 0
var newHighScore = false

func _on_Update(data, data2):
	highscore = data
	newHighScore = data2
	
	if newHighScore == true:
		text = "Highscore: " + "NEW HIGHSCORE!"
	else:
		text = "Highscore: " + str(data)
