extends Marker3D

@export_range(0.0, 1.0, 0.01, "suffix:s") var goal_time: float = 0.5
@export_range(0.0, 10.0, 0.5, "suffix:m") var look_ahead: float = 4.0

var t = 0.0

func _physics_process(delta: float) -> void:
	var player = $"../Player"
	var distance_ahead = look_ahead * player.velocity.normalized()
	var future_pos = player.position + distance_ahead
	if player.velocity == Vector3.ZERO:
		t = 0.1
	t += delta / goal_time
	t = min(t, 0.1)
	position = lerp(position, future_pos, t)
	 
