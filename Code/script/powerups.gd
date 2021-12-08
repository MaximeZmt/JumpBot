extends Sprite

# 0 = double_jump
# 1 = inverse_direction
# 2 = jump_increase
# 3 = speed_increase

export var value = 0

func _on_Area2D_body_shape_entered(body_id, body, body_shape, area_shape):
	if body.name == "Player":
		get_tree().call_group("showPowerup", "get_powerup", value)
		queue_free()
