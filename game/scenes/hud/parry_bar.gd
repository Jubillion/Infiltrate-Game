extends ProgressBar

func _process(_delta: float) -> void:
	value = 1 - $"../../Player/ParryCooldown".time_left / $"../../Player/ParryCooldown".wait_time
	visible = value != 1.0
