extends Label

func get_online_score(top10, before10, after10, score):
	self.set_text("User Online Score: " + String(score))
