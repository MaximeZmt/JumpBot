extends Node

var config

func _on_setHighscore(highscore):
	config = ConfigFile.new()
	config.load("user://settings.cfg")
	var username = config.get_value("settings", "username")
	var password = config.get_value("settings", "password")
	var result = 0 #httpRequest(username, password, "/setScore/", highscore) Disable online feature, server are down
	
	if typeof(result) == TYPE_STRING:
		if result == "Score Set":
			print("Score Set")
		else:
			print(result)
		
	get_node("../FullScreens/UploadScreen").hide()

func _on_getHighscore():
	config = ConfigFile.new()
	config.load("user://settings.cfg")
	var username = config.get_value("settings", "username")
	var result = 0 #httpRequest(username, null, "/getScore/", null) Disable online
	
	if typeof(result) == TYPE_STRING:
		result = int(result)
		get_node("../CanvasLayer/highscore").highscore = result
	else:
		get_node("../CanvasLayer/highscore").highscore = -1
	
	get_tree().paused = false
	get_node("../FullScreens/LoadingScreen").hide()

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
	
	if (http.get_status() != HTTPClient.STATUS_BODY and http.get_status() != HTTPClient.STATUS_CONNECTED):
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
