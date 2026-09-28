extends Label
class_name Dmg_label
@onready var display_text : String = ""

func _ready() -> void:
	get_tree().create_timer(0.2).timeout.connect(func()->void: queue_free())

func setText(_text:String):
	text = _text
func _physics_process(delta: float) -> void:
	position.y -= 2
