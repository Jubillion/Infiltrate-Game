extends Node3D

@export var safe_radius := 0
@export_range(0.0, 1.0, 0.01) var enemy_chance := 0.5

var current_scene = load("res://scenes/room/room.tscn") as PackedScene

func _ready() -> void:
	pass

func _on_left_side_screen_entered() -> void:
	var instance = current_scene.instantiate()
	instance.position = position + Vector3.LEFT * 8
	instance.get_node("RightSide").queue_free()
	instance.safe_radius = max(0, safe_radius - 1)
	add_sibling(instance)
	$LeftSide.queue_free()

func _on_right_side_screen_entered() -> void:
	var instance = current_scene.instantiate()
	instance.position = position + Vector3.RIGHT * 8
	instance.get_node("LeftSide").queue_free()
	instance.safe_radius = max(0, safe_radius - 1)
	add_sibling(instance)
	$RightSide.queue_free()
