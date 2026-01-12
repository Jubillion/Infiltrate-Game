extends WorldEnvironment

@export var game_scene: PackedScene

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("start") and get_child_count() < 4:
		var main = game_scene.instantiate()
		add_child(main)
		$Background/Camera.current = false
		$Main/CameraTarget/Camera.current = true
		$Background.hide()
		$GUI.hide()
