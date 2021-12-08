extends CanvasLayer
var double_jump
var inverse_direction
var jump_increase
var speed_increase

func _ready():
	double_jump = get_node("double_jump")
	inverse_direction = get_node("inverse_direction")
	jump_increase = get_node("jump_increase")
	speed_increase = get_node("speed_increase")


func get_powerup(powerup):
	if powerup == 0:
		double_jump.show()
	elif powerup == 1:
		inverse_direction.show()
	elif powerup == 2:
		jump_increase.show()
	elif powerup == 3:
		speed_increase.show()
	else:
		print("Error Invalid Powerup Number")