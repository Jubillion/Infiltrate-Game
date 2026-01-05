extends CharacterBody3D

@export var speed := 8.0

signal killed

func _physics_process(_delta: float) -> void:
	var player_pos = $"../Player".position.x
	
	velocity = Vector3.ZERO
	if player_pos < position.x:
		velocity = Vector3.LEFT * speed
		rotation.y = PI/2
	elif player_pos > position.x:
		velocity = Vector3.RIGHT * speed
		rotation.y = -PI/2
	
	move_and_slide()

func kill() -> void:
	killed.emit()
	queue_free()
