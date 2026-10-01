extends CharacterBody2D
class_name EnemyBody


@export var base_health := 10.0
@export var target : Player
signal HP_EMPTY
func _ready() -> void:
	if target == null:
		target = get_tree().get_nodes_in_group("PLAYER")[0]
	#PLAYER_FSM = target.get_player_state_machine()



func hitstop(duration:float,speed:float)->void:
	Engine.time_scale = speed
	await get_tree().create_timer(duration).timeout
	Engine.time_scale =1

func knockBack(sourcePosition : Vector2,knockbackForce:float)->void:
	velocity.x = +sourcePosition.x*knockbackForce
func hitted(dmg:float)->void:
	base_health -= dmg
	if base_health < 1:
		HP_EMPTY.emit()
