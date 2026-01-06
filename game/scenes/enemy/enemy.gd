extends CharacterBody3D

@export var speed := 8.0
@export var damage := 10.0

var parry_time = 200

signal killed
signal parry_success

func _ready() -> void:
	$"../Player".parried.connect(_on_player_parried)

func _physics_process(_delta: float) -> void:
	var player_pos = $"../Player".position.x
	
	velocity = Vector3.ZERO
	if player_pos < position.x:
		velocity = Vector3.LEFT * speed
		rotation.y = PI/2
	elif player_pos > position.x:
		velocity = Vector3.RIGHT * speed
		rotation.y = -PI/2
	
	var atk_timer = $AttackWarmup
	var atk_progress = (atk_timer.wait_time - atk_timer.time_left) / atk_timer.wait_time
	if atk_timer.is_stopped():
		$ArmPivot.rotation.x = 2*PI/3
	else:
		$ArmPivot.rotation.x = lerpf(2*PI/3, 5*PI/12, atk_progress)
	
	move_and_slide()

func kill() -> void:
	killed.emit()
	queue_free()

func attack():
	if $AttackWarmup.is_stopped():
		$AttackWarmup.start()

func _on_attack_area_body_entered(body: Node3D) -> void:
	if body == $"../Player":
		attack()

func _on_attack_warmup_timeout() -> void:
	$"../Player".health = max($"../Player".health - damage, 0)

func _on_player_parried() -> void:
	if $AttackWarmup.time_left >= parry_time * 1e3:
		parry_success.emit()
		queue_free()
