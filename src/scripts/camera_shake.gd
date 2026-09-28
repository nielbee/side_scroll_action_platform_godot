extends Camera2D

@onready var _strenght : float = 1
@onready var _fade_time : float = 0.3

var _canShake = false

func set_shake(strenght : float, fade :float)->void:
	_strenght = strenght
	_fade_time = fade
	_canShake = true

func _physics_process(delta: float) -> void:
	var rand :=Vector2(randf_range(-_strenght,_strenght),randf_range(-_strenght,_strenght))
	if _canShake:
		offset = rand
		_strenght -= _fade_time*delta
		clampf(_strenght,0,_strenght)
		if _strenght < 0.0:
			_canShake = false
		

	
