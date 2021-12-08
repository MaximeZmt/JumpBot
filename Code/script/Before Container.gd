extends VBoxContainer

func display_users(top10, before10, after10, score):
	var data = []
	var i = 0
	
	while(i != 10):
		get_node("user"+ String(i)).hide()
		i += 1
	
	if before10[0].empty() == false:
		self.show()
		get_node("../Before10").show()
		i = 0
		while(i != before10.size()):
			data = before10[i].split(" ", false, 1)
			get_node("user"+ String(i) +"/user").set_text(data[0])
			get_node("user"+ String(i) + "/score").set_text(data[1])
			get_node("user"+ String(i)).show()
			i += 1
	else:
		self.hide()
		get_node("../Before10").hide()
	
	i = 0
	while(i != 10):
		if get_node("user"+ String(i) +"/user").get_text() == "user" || get_node("user"+ String(i) +"/score").get_text() == "score":
			get_node("user"+ String(i)).hide()
		i += 1