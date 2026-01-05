extends Marker3D

func _ready() -> void:
	basis = Basis.looking_at(Vector3.RIGHT)

func _process(_delta: float) -> void:
	if $"..".velocity != Vector3.ZERO:
		basis = Basis.looking_at($"..".velocity)
