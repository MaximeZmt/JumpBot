extends ScrollContainer
#
#var swipe_start = null
#var minimum_drag = 100
#var scroll = get_v_scroll()
#var i = 0
#var scrolling = true
#var holding = false
#var holdTimer = 0
#var magnitude = 1
#var direction = "up"
#var currentlyMoving = false
##Total Scroll Length: 576
#
#func calculate_swipe(swipe_end):
#	if swipe_start == null:
#		return
#	var swipe = swipe_end - swipe_start
#	print(swipe)
#	if abs(swipe.y) > minimum_drag:
#		scrolling = true
#
#		if swipe.y <= 200:
#			magnitude = 1
#		elif swipe.y <= 300:
#			magnitude = 2
#		elif swipe.y <= 400:
#			magnitude = 3
#		elif swipe.y <= 500:
#			magnitude = 4
#
#		if swipe.y > 0 and direction == "down" and currentlyMoving == true:
#			scrolling = false
#		elif swipe.y < 0 and direction == "up" and currentlyMoving == true:
#			scrolling = false
#
#		if swipe.y > 0:
#			currentlyMoving = true
#			direction = "up"
#			print("up")
#			if scroll >= 0:
#				i = 0
#				while (i <= (2 * magnitude) and scrolling == true):
#					scroll -= 10
#					yield(get_tree().create_timer(.1), "timeout")
#					set_v_scroll(scroll)
#					i += 1
#				i = 0
#				while (i <= (6) and scrolling == true):
#					scroll -= 5
#					yield(get_tree().create_timer(.1), "timeout")
#					set_v_scroll(scroll)
#					i += 1
#				i = 0
#				#while (i <= 5 and scrolling == true):
#				#	scroll -= 1
#				#	yield(get_tree().create_timer(.1), "timeout")
#				#	set_v_scroll(scroll)
#				#	i += 1
#				#i = 0
#				currentlyMoving = false
#			else:
#				scroll = 0
#		else:
#			currentlyMoving = true
#			direction = "down"
#			print("down")
#			if scroll <= 576:
#				i = 0
#				while (i <= (2 * magnitude) and scrolling == true):
#					scroll += 10
#					yield(get_tree().create_timer(.1), "timeout")
#					set_v_scroll(scroll)
#					i += 1
#				i = 0
#				while (i <= (6) and scrolling == true):
#					scroll += 5
#					yield(get_tree().create_timer(.1), "timeout")
#					set_v_scroll(scroll)
#					i += 1
#				i = 0
#				currentlyMoving = false
#				#while (i <= 5 and scrolling == true):
#				#	scroll += 1
#				#	yield(get_tree().create_timer(.1), "timeout")
#				#	set_v_scroll(scroll)
#				#	i += 1
#				#i = 0
#			else:
#				scroll = 576
#	else:
#		scrolling = false
#
#func _process(delta):
#	if holding == true:
#		holdTimer += 1
#	else:
#		holdTimer = 0
#
#	if holdTimer == 15:
#		scrolling = false
#		holding = false
#		print("stop")
#		holdTimer = 0
#
#func _input(event):
#	if event.is_action_pressed("click"):
#		holding = true
#		swipe_start = event.position
#	if event.is_action_released("click"):
#		holding = false
#		calculate_swipe(event.position)