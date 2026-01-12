extends ProgressBar

func _process(_delta: float) -> void:
	value = $"../../Player".health
	max_value = $"../../Player".max_health
