extends Node

func _on_Account_deleteAccount(username, password):
	get_node("../LoadingScreen").show()
	yield(get_tree().create_timer(0.1), "timeout")
	
	var result = 0 #httpRequest(username, password, "/deleteAccount/", null) disable online
	
	if typeof(result) == TYPE_STRING:
		if result == password:
			var config = ConfigFile.new()
			config.load("user://settings.cfg")
			config.set_value("settings", "username", null)
			config.set_value("settings", "password", null)
			config.save("user://settings.cfg")
			get_node("../Background/Scroll/SettingsBox/More").hide()
			get_node("../Background/Scroll/SettingsBox/Options/ChangeAccount").set_text("CONNECT ACCOUNT")
			get_node("../Background/Scroll/SettingsBox/Options").show()
			get_node("../Background/Scroll/SettingsBox/Options/More").hide()
			get_node("../Background/Scroll/SettingsBox/Reset Online Score").hide()
			get_node("../Background/Scroll/SettingsBox/Reset Online Score Result").hide()
			get_node("../Background/Scroll/SettingsBox/Options/ChangePassword").hide()
			get_node("../Background/Scroll/SettingsBox/Separator11").hide()
			get_node("../Background/Scroll/SettingsBox/Online Ranking").hide()
			get_node("../Background/Scroll/SettingsBox/Online Ranking Result").hide()
			get_node("../Background/Scroll/SettingsBox/Separator5").hide()
			get_node("../Background/Scroll/SettingsBox/deleteAccount").hide()
		else:
			get_node("../Background/Scroll/SettingsBox/deleteAccount/Result").set_text("FAILED")
			get_node("../Background/Scroll/SettingsBox/deleteAccount/Result").show()
	else:
		get_node("../Background/Scroll/SettingsBox/deleteAccount/Result").set_text("FAILED")
		get_node("../Background/Scroll/SettingsBox/deleteAccount/Result").show()
		
	get_node("../LoadingScreen").hide()

func _on_Online_Ranking_pressed():
	var viewable
	var seeOnlineScores
	
	get_node("../LoadingScreen").show()
	yield(get_tree().create_timer(0.1), "timeout")
	
	if get_node("../Background/Scroll/SettingsBox/Online Ranking").is_pressed():
		viewable = 1
		seeOnlineScores = true
	else:
		viewable = 0
		seeOnlineScores = false
		
	print(viewable)
	
	var config = ConfigFile.new()
	config.load("user://settings.cfg")
	var username = config.get_value("settings", "username")
	var password = config.get_value("settings", "password")

	var result = 0 #httpRequest(username, password, "/toggleOnlineRanking/", viewable) Disable online
	
	if typeof(result) == TYPE_STRING:
		if result == password:
			config.set_value("settings", "online_ranking", seeOnlineScores)
			config.save("user://settings.cfg")
			get_node("../Background/Scroll/SettingsBox/Online Ranking Result").set("custom_colors/font_color", Color(0,1,0))
			get_node("../Background/Scroll/SettingsBox/Online Ranking Result").set_text("SUCCESS")
			get_node("../Background/Scroll/SettingsBox/Online Ranking Result").show()
		else:
			get_node("../Background/Scroll/SettingsBox/Online Ranking Result").set("custom_colors/font_color", Color(1,0,0))
			get_node("../Background/Scroll/SettingsBox/Online Ranking Result").set_text("FAILED")
			get_node("../Background/Scroll/SettingsBox/Online Ranking Result").show()
			if viewable == 1:
				get_node("../Background/Scroll/SettingsBox/Online Ranking").set_pressed(false)
			else:
				get_node("../Background/Scroll/SettingsBox/Online Ranking").set_pressed(true)
	else:
		get_node("../Background/Scroll/SettingsBox/Online Ranking Result").set("custom_colors/font_color", Color(1,0,0))
		get_node("../Background/Scroll/SettingsBox/Online Ranking Result").set_text("FAILED")
		get_node("../Background/Scroll/SettingsBox/Online Ranking Result").show()
		if viewable == 1:
			get_node("../Background/Scroll/SettingsBox/Online Ranking").set_pressed(false)
		else:
			get_node("../Background/Scroll/SettingsBox/Online Ranking").set_pressed(true)
	
	get_node("../LoadingScreen").hide()

func _on_Reset_Online_Score():
	get_node("../LoadingScreen").show()
	yield(get_tree().create_timer(0.1), "timeout")
	
	var config = ConfigFile.new()
	config.load("user://settings.cfg")
	var username = config.get_value("settings", "username")
	var password = config.get_value("settings", "password")
	
	var result = 0 #httpRequest(username, password, "/resetScore/", null) Disable online
	
	if typeof(result) == TYPE_STRING:
		if result == password:
			get_node("../Background/Scroll/SettingsBox/Reset Online Score Result").set("custom_colors/font_color", Color(0,1,0))
			get_node("../Background/Scroll/SettingsBox/Reset Online Score Result").set_text("SUCCESS")
			get_node("../Background/Scroll/SettingsBox/Reset Online Score Result").show()
		else:
			get_node("../Background/Scroll/SettingsBox/Reset Online Score Result").set("custom_colors/font_color", Color(1,0,0))
			get_node("../Background/Scroll/SettingsBox/Reset Online Score Result").set_text("FAILED")
			get_node("../Background/Scroll/SettingsBox/Reset Online Score Result").show()
	else:
		get_node("../Background/Scroll/SettingsBox/Reset Online Score Result").set("custom_colors/font_color", Color(1,0,0))
		get_node("../Background/Scroll/SettingsBox/Reset Online Score Result").set_text("FAILED")
		get_node("../Background/Scroll/SettingsBox/Reset Online Score Result").show()
		
	get_node("../LoadingScreen").hide()

func _on_Account_changePassword(username, oldPassword, newPassword):
	get_node("../LoadingScreen").show()
	yield(get_tree().create_timer(0.1), "timeout")
	
	var result = 0 #httpRequest(username, oldPassword, "/changePassword/", newPassword) Disable online
	if typeof(result) == TYPE_STRING:
		if result == newPassword:
			print(newPassword)
			get_node("../Background/Scroll/SettingsBox/changePassword").hide()
			get_node("../Background/Scroll/SettingsBox/Options").show()
			var config = ConfigFile.new()
			config.load("user://settings.cfg")
			config.set_value("settings", "password", newPassword)
			config.save("user://settings.cfg")
			get_node("../Background/Scroll/SettingsBox/changePassword/Result").hide()
			get_node("../Background/Scroll/SettingsBox/changePassword/Old Password").clear()
			get_node("../Background/Scroll/SettingsBox/changePassword/New Password").clear()
			get_node("../Background/Scroll/SettingsBox/changePassword/New Password Check").clear()
		else:
			get_node("../Background/Scroll/SettingsBox/changePassword/Result").set_text("FAILED")
			get_node("../Background/Scroll/SettingsBox/changePassword/Result").show()
	else:
		get_node("../Background/Scroll/SettingsBox/loginForm/Result").set_text("FAILED")
		get_node("../Background/Scroll/SettingsBox/loginForm/Result").show()
	
	get_node("../LoadingScreen").hide()

func _on_Account_login(username, password):
	get_node("../LoadingScreen").show()
	yield(get_tree().create_timer(0.1), "timeout")
	
	var result = 0 #httpRequest(username, password, "/login/", null) Disable online
	
	if typeof(result) == TYPE_STRING:
		if result == password:
			print(password)
			get_node("../Background/Scroll/SettingsBox/loginForm").hide()
			get_node("../Background/Scroll/SettingsBox/Options").show()
			var config = ConfigFile.new()
			config.load("user://settings.cfg")
			config.set_value("settings", "username", username)
			config.set_value("settings", "password", password)
			config.save("user://settings.cfg")
			get_node("../Background/Scroll/SettingsBox/loginForm/Result").hide()
			get_node("../Background/Scroll/SettingsBox/Options/More").show()
			get_node("../Background/Scroll/SettingsBox/Reset Online Score").show()
			get_node("../Background/Scroll/SettingsBox/Options/ChangePassword").show()
			get_node("../Background/Scroll/SettingsBox/Separator11").show()
			get_node("../Background/Scroll/SettingsBox/Online Ranking").show()
			get_node("../Background/Scroll/SettingsBox/Separator5").show()
			get_node("../Background/Scroll/SettingsBox/Options/ChangeAccount").set_text("CHANGE ACCOUNT")
			get_node("../Background/Scroll/SettingsBox/loginForm/Username").clear()
			get_node("../Background/Scroll/SettingsBox/loginForm/Password").clear()
		else:
			get_node("../Background/Scroll/SettingsBox/loginForm/Result").set_text("FAILED")
			get_node("../Background/Scroll/SettingsBox/loginForm/Result").show()
	else:
		get_node("../Background/Scroll/SettingsBox/loginForm/Result").set_text("FAILED")
		get_node("../Background/Scroll/SettingsBox/loginForm/Result").show()
		
	get_node("../LoadingScreen").hide()

func _on_Account_signUp(username, password):
	get_node("../LoadingScreen").show()
	yield(get_tree().create_timer(0.1), "timeout")
	
	var result = 0 #httpRequest(username, password, "/signUp/", null) disable online feature
	if typeof(result) == TYPE_STRING:
		if result == password:
			print(password)
			var config = ConfigFile.new()
			get_node("../Background/Scroll/SettingsBox/signUpForm").hide()
			get_node("../Background/Scroll/SettingsBox/Options").show()
			config.load("user://settings.cfg")
			config.set_value("settings", "username", username)
			config.set_value("settings", "password", password)
			config.save("user://settings.cfg")
			get_node("../Background/Scroll/SettingsBox/signUpForm/Result").hide()
			get_node("../Background/Scroll/SettingsBox/Options/More").show()
			get_node("../Background/Scroll/SettingsBox/Reset Online Score").show()
			get_node("../Background/Scroll/SettingsBox/Options/ChangePassword").show()
			get_node("../Background/Scroll/SettingsBox/Separator11").show()
			get_node("../Background/Scroll/SettingsBox/Online Ranking").show()
			get_node("../Background/Scroll/SettingsBox/Separator5").show()
			get_node("../Background/Scroll/SettingsBox/Options/ChangeAccount").set_text("CHANGE ACCOUNT")
			get_node("../Background/Scroll/SettingsBox/signUpForm/Username").clear()
			get_node("../Background/Scroll/SettingsBox/signUpForm/Password").clear()
			get_node("../Background/Scroll/SettingsBox/signUpForm/Confirm Password").clear()
		else:
			get_node("../Background/Scroll/SettingsBox/signUpForm/Result").set_text("FAILED")
			get_node("../Background/Scroll/SettingsBox/signUpForm/Result").show()
	else:
		get_node("../Background/Scroll/SettingsBox/signUpForm/Result").set_text("FAILED")
		get_node("../Background/Scroll/SettingsBox/signUpForm/Result").show()
	
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
