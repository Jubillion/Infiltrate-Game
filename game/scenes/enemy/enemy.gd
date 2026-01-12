extends CharacterBody3D

@export var speed := 8.0
@export var damage := 5
@export var parry_time = 125

var is_parryable = false

signal killed

var mat: BaseMaterial3D

func _ready() -> void:
	set_enemy_type()
	$"../Player".parried.connect(_on_player_parried)
	mat = load("res://scenes/enemy/enemy.tres") as BaseMaterial3D
	mat = mat.duplicate()
	$Character.set_surface_override_material(0, mat)
	$ArmPivot/LeftArm.set_surface_override_material(0, mat)
	$ArmPivot/RightArm.set_surface_override_material(0, mat)

func _process(_delta: float) -> void:
	is_parryable = $AttackWarmup.time_left <= parry_time / 1e3 && $AttackWarmup.time_left > 0
	mat.emission = Color.WHITE if is_parryable else mat.albedo_color

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
	if $AttackCooldown.is_stopped():
		$"../Player".health = max($"../Player".health - damage, 0)
		$AttackCooldown.start()
		await $AttackCooldown.timeout
		if $ArmPivot/AttackArea.get_overlapping_bodies().has($"../Player"):
			attack()

func _on_player_parried() -> void:
	is_parryable = $AttackWarmup.time_left <= parry_time / 1e3 && $AttackWarmup.time_left > 0
	if is_parryable && $ArmPivot/AttackArea.get_overlapping_areas().has($"../Player/WeaponArea"):
		$"../Player/ParryCooldown".stop()
		$"../Audio/ParryFail".stop()
		$"../Audio/ParrySuccess".play()
		$"../Player".expe += 60 / $"../Player".level
		queue_free()

func set_enemy_type() -> void:
	pass
