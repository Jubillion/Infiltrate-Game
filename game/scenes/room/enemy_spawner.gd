extends Path3D

@export var enemy_scene: PackedScene
@export var enemies_advanced: Array[PackedScene]
@export var heart_scene: PackedScene
var advanced_chance: float

func _ready():
	var is_safe = $"..".safe_radius > 0
	var enemy_chance = $"..".enemy_chance
	if not is_safe:
		var enemy
		advanced_chance = min(0.17 * $"../../Player".level, 1)
		if  enemy_chance > randf():
			enemy = (
				enemies_advanced.pick_random().instantiate() if advanced_chance > randf()
				else enemy_scene.instantiate()
			)
		else:
			enemy = heart_scene.instantiate()
		$EnemySpawnPoint.progress_ratio = randf()
		enemy.position = $EnemySpawnPoint.position + $"..".position
		$"../..".call_deferred("add_child", enemy)
