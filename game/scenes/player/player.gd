extends CharacterBody3D

@export var speed := 10.0

var health = 100
var max_health = 100

signal parried

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if velocity != Vector3.ZERO:
		basis = Basis.looking_at(velocity)
	if Input.is_action_just_pressed("parry") and $ParryCooldown.is_stopped():
		$ParryCooldown.start()
	parried.emit()

func _physics_process(_delta: float) -> void:
	var direction = 0
	if Input.is_action_pressed("move_left"):
		direction -= 1
	if Input.is_action_pressed("move_right"):
		direction += 1
	velocity.x = direction * speed
	
	move_and_slide()

func _on_parry_success() -> void:
	$ParryCooldown.stop()
