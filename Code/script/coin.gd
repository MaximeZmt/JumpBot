extends Sprite

export var value = 0

func _on_Area2D_body_shape_entered(body_id, body, body_shape, area_shape):
	if body.name == "Player":
		queue_free()
		get_tree().call_group("score", "get_value", value)