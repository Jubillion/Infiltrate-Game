extends CharacterBody3D

@export var speed := 8.0

signal killed

func _physics_process(delta: float) -> void:
	var player_pos = $"../Player".position.x
	
	velocity = Vector3.ZERO
	if player_pos < position.x:
		velocity = Vector3.LEFT * speed
	elif player_pos > position.x:
		velocity = Vector3.RIGHT * speed
	
	move_and_slide()

func kill() -> void:
	killed.emit()
	queue_free()
