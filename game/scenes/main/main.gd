extends Node3D

func _process(_delta: float) -> void:
	if $Player.health == 0:
		$"../Background".show()
		$"../GUI".show()
		queue_free()
