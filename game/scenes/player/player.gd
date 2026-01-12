extends CharacterBody3D

@export var speed := 10.0

var health := 100
var max_health = 100
var expe = 0
var max_exp = 200.0
var level = 1

signal parried

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("parry") and $ParryCooldown.is_stopped():
		$ParryCooldown.start()
		$"../Audio/ParryFail".play()
		parried.emit()
	if expe >= max_exp:
		level += int(expe / max_exp)
		expe %= int(max_exp)

func _physics_process(_delta: float) -> void:
	var direction = 0
	if Input.is_action_pressed("move_left"):
		direction -= 1
	if Input.is_action_pressed("move_right"):
		direction += 1
	velocity.x = direction * speed
	if velocity != Vector3.ZERO:
		basis = Basis.looking_at(velocity)
	
	move_and_slide()
	
