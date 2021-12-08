extends ColorRect

signal dead

var isDoubleJumpActive = false
var isInverseDirectionActive = false
var isJumpIncreaseActive = false
var isSpeedIncreaseActive = false
var dead = false

func _physics_process(delta):
	if(get_tree().paused):
		visible = true
		
		if get_node("../double_jump").visible == true:
			isDoubleJumpActive = true
			get_node("../double_jump").hide()
		if get_node("../inverse_direction").visible == true:
			isInverseDirectionActive = true
			get_node("../inverse_direction").hide()
		if get_node("../jump_increase").visible == true:
			isJumpIncreaseActive = true
			get_node("../jump_increase").hide()
		if get_node("../speed_increase").visible == true:
			isSpeedIncreaseActive = true
			get_node("../speed_increase").hide()
			
	else:
		visible = false
		
		if isDoubleJumpActive == true:
			get_node("../double_jump").show()
			isDoubleJumpActive = false
		if isInverseDirectionActive == true:
			get_node("../inverse_direction").show()
			isInverseDirectionActive = false
		if isJumpIncreaseActive == true:
			get_node("../jump_increase").show()
			isJumpIncreaseActive = false
		if isSpeedIncreaseActive == true:
			get_node("../speed_increase").show()
			isSpeedIncreaseActive = false

func _on_retry_pressed():
	if dead == false:
		emit_signal("dead")
		yield(get_node("../highscore"), "continueFunction")
	get_tree().reload_current_scene()
	get_tree().paused = false

func _on_menu_pressed():
	if dead == false:
		emit_signal("dead")
		yield(get_node("../highscore"), "continueFunction")
	get_node("../../FullScreens/MenuLoading").show()
	yield(get_tree().create_timer(0.1), "timeout")
	get_tree().change_scene("res://scenes/menu.tscn")
	get_tree().paused = false

func _on_Player_dead():
	dead = true
