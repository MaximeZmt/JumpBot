extends Label

func selected_player(username):
	self.set_text("Selected Player: " + String(username))