extends Marker3D

func _process(_delta: float) -> void:
	if Input.is_action_pressed("parry"):
		rotation.y = PI/4
	else:
		rotation.y = 0
