extends Node3D

@export var heal_amount = 30

var init_pos: Vector3
var amplitude = 0.3
var swivel = PI / 12

func _ready() -> void:
	init_pos = position

func _process(_delta: float) -> void:
	var t = 1 - $AnimationTimer.time_left / $AnimationTimer.wait_time
	position = init_pos + Vector3.UP * amplitude * sin(4 * PI * t)
	rotation.y = swivel * sin(2 * PI * t)

func _on_heart_area_body_entered(body: Node3D) -> void:
	if body == $"../Player":
		$"../Player".health = min(100, $"../Player".health + heal_amount)
		$"../Audio/HeartSound".play()
		queue_free()
