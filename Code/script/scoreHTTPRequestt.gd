extends Node

signal give_data

func scoreboard(username):
	get_node("../LoadingScreen").show()
	yield(get_tree().create_timer(0.1), "timeout")
	var top10 = []
	var before10 = []
	var after10 = []
	var score
	var i
	var result = 0#httpRequest(username, null, "/scoreboard/", null) Disable online
	if typeof(result) == TYPE_STRING:
		if result.find('"top10"') != -1:
			result = result.replace('"','')
			var results = result.split(', ', false, 4)
			results[0] = results[0].replace('{top10:{', '')
			results[1] = results[1].replace('before10:{', '')
			results[2] = results[2].replace('after10:{', '')
			results[2] = results[2].replace('}', '')
			results[0] = results[0].replace('}', '')
			results[1] = results[1].replace('}', '')
			results[3] = results[3].replace('}', '')
			
			top10 = results[0].split(',', true, 10)
			i = 0
			if top10[0].empty() == false:
				while(i != top10.size()):
					top10[i] = top10[i].replace('user' + String(i) + ':', '')
					i += 1
			
			
			before10 = results[1].split(',', true, 10)
			i = 0
			if before10[0].empty() == false:
				while(i != before10.size()):
					before10[i] = before10[i].replace('user' + String(i) + ':', '')
					i += 1
	
			after10 = results[2].split(',', true, 10)
			i = 0
			if after10[0].empty() == false:
				while(i != after10.size()):
					after10[i] = after10[i].replace('user' + String(i) + ':', '')
					i += 1
			
			score = results[3].replace('score:', '')
			
			get_node("../Background/Scroll/ScoresBox/No Player").hide()
			emit_signal("give_data", top10, before10, after10, score)
		else:
				get_node("../Background/Scroll/ScoresBox/No Player").show()
				get_node("../Background/Scroll/ScoresBox/Subtitle").hide()
				get_node("../Background/Scroll/ScoresBox/Separator2").hide()
				get_node("../Background/Scroll/ScoresBox/Online Score").hide()
				get_node("../Background/Scroll/ScoresBox/Top10").hide()
				get_node("../Background/Scroll/ScoresBox/Top Container").hide()
				get_node("../Background/Scroll/ScoresBox/After10").hide()
				get_node("../Background/Scroll/ScoresBox/After Container").hide()
				get_node("../Background/Scroll/ScoresBox/Before10").hide()
				get_node("../Background/Scroll/ScoresBox/Before Container").hide()
	
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
