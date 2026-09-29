extends AnimatedSprite2D
class_name Instantiator


func _ready() -> void:
	await animation_finished
	queue_free()
