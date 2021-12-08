extends Node

var config

func _on_menu_scene_message(number):
	get_node("../MenuLoading").show()
	yield(get_tree().create_timer(0.2), "timeout")
	var result = 0 #httpRequest(null, null, "/getUpdate/", number) Disable online request server are down
	if typeof(result) == TYPE_STRING:
		if result.find('"message"') != -1:
			result = result.replace('"','')
			var results = result.split(', ', false, 2)
			results[0] = results[0].replace('{id:', '')
			results[1] = results[1].replace('message:', '')
			results[1] = results[1].replace('}', '')
			config = ConfigFile.new()
			config.load("user://settings.cfg")
			if config.get_value("settings", "updates_from_developers_number") < int(results[0]):
				config.set_value("settings", "updates_from_developers_number", int(results[0]))
				config.save("user://settings.cfg")
				get_node("../developerUpdate/Scroll/SettingsBox/Text").set_text(results[1])
				get_node("../developerUpdate").show()
		else:
			print("ERROR")
			print(result)
	else:
		print("ERROR")
		print(result)
		
	get_node("../MenuLoading").hide()

func _on_menu_scene_login(username, password):
	get_node("../LoadingScreen").show()
	yield(get_tree().create_timer(0.1), "timeout")
	
	var result = 0#httpRequest(username, password, "/login/", null) Disable online
	
	if typeof(result) == TYPE_STRING:
		if result == password:
			get_node("../logIn").hide()
			get_tree().paused = false
			config = ConfigFile.new()
			config.load("user://settings.cfg")
			config.set_value("settings", "username", username)
			config.set_value("settings", "password", password)
			config.save("user://settings.cfg")
			get_node("../menu/subMenu/play/OnlineMode").show()
		else:
			get_node("../logIn/VBoxContainer/Result").set_text("FAILED")
	else:
		get_node("../logIn/VBoxContainer/Result").set_text("FAILED")
	
	get_node("../LoadingScreen").hide()


func _on_menu_scene_signUp(username, password):
	get_node("../LoadingScreen").show()
	yield(get_tree().create_timer(0.1), "timeout")
	
	var result = 0#httpRequest(username, password, "/signUp/", null) Disable online
	
	if typeof(result) == TYPE_STRING:
		if result == password:
			get_node("../signUp").hide()
			get_tree().paused = false
			config = ConfigFile.new()
			config.load("user://settings.cfg")
			config.set_value("settings", "username", username)
			config.set_value("settings", "password", password)
			config.save("user://settings.cfg")
			get_node("../menu/subMenu/play/OnlineMode").show()
		else:
			get_node("../signUp/VBoxContainer/Result").set_text("FAILED")
	else:
		get_node("../logIn/VBoxContainer/Result").set_text("FAILED")
	
	get_node("../LoadingScreen").hide()


func httpRequest(username, password, page, data):
	var query = '{"username":"' + str(username) + '","password":"' + str(password) + '","data":"' + str(data) +'"}'
	var headers = ["User-Agent: Jumpbot/1.0", "Accept: */*"]
	var url = "api.ketashi.com"
	var port = 443
	var err = 0
	var text
	var http = HTTPClient.new()
	
	err = http.connect_to_host(url, port, true, true)
	
	if (err != OK):
		return 0
	
	var i = 0
	while http.get_status() == HTTPClient.STATUS_CONNECTING or http.get_status() == HTTPClient.STATUS_RESOLVING:
		http.poll()
		print("Connecting...")
		OS.delay_msec(500)
		if i == 10:
			return 0
		i += 1
	
	if (http.get_status() != HTTPClient.STATUS_CONNECTED):
		return 0
	
	err = http.request(HTTPClient.METHOD_POST, page, headers, query)
	
	if (err != OK):
		return 0
	
	while http.get_status() == HTTPClient.STATUS_REQUESTING:
		http.poll()
		print("Requesting...")
		if not OS.has_feature("web"):
			OS.delay_msec(500)
		else:
			yield(Engine.get_main_loop(), "idle_frame")
	
	if http.get_status() != HTTPClient.STATUS_BODY and http.get_status() != HTTPClient.STATUS_CONNECTED:
		return 0
	
	if http.has_response():
		var rb = PoolByteArray()
		
		while http.get_status() == HTTPClient.STATUS_BODY:
			http.poll()
			var chunk = http.read_response_body_chunk()
			if chunk.size() == 0:
				OS.delay_usec(1000)
			else:
				rb = rb + chunk
		text = rb.get_string_from_ascii()
	
	http.close()
	return text
