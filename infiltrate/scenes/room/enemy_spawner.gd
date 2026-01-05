extends Path3D

@export var enemy_scene: PackedScene

func _ready():
	var is_safe = $"..".safe_radius > 0
	var enemy_chance = $"..".enemy_chance
	if not is_safe and enemy_chance > randf():
		var enemy = enemy_scene.instantiate()
		$EnemySpawnPoint.progress_ratio = randf()
		enemy.position = $EnemySpawnPoint.position
		add_child(enemy)
