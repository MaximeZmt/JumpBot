extends VBoxContainer

func display_users(top10, before10, after10, score):
	var data = []
	var i = 0
	
	while(i != 10):
		get_node("user"+ String(i)).hide()
		i += 1
	
	if after10[0].empty() == false:
		self.show()
		get_node("../After10").show()
		i = 0
		while(i != after10.size()):
			data = after10[i].split(" ", false, 1)
			get_node("user"+ String(i) +"/user").set_text(data[0])
			get_node("user"+ String(i) + "/score").set_text(data[1])
			get_node("user"+ String(i)).show()
			print(i)
			i += 1
			
	else:
		self.hide()
		get_node("../After10").hide()
	
	i = 0
	while(i != 10):
		if get_node("user"+ String(i) +"/user").get_text() == "user" || get_node("user"+ String(i) +"/score").get_text() == "score":
			get_node("user"+ String(i)).hide()
		i += 1