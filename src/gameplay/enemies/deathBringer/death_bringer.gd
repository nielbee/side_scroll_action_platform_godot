extends EnemyBody

class_name EnemyBossDeathbringer
@onready var sprite: AnimatedSprite2D = $sprite
@onready var fsm: FiniteStateMachine = $FSM

const ATTACK_DISTANCE := 60.0
var distanceToPlayer : Vector2 
@onready var _active := true
@onready var PLAYER_FSM : FiniteStateMachine
@onready var _atas_kepala: Node2D = $instantiate_location/atas_kepala



func _physics_process(delta: float) -> void:
	distanceToPlayer =target.global_position - global_position
	



func flipDeathBringer(flip : bool)->void :
	if flip : sprite.scale.x = -1
	else : sprite.scale.x = 1
	


func _on_hurtbox_area_entered(area: Area2D) -> void:   #hitted by player
	
	if area.is_in_group("player_hitbox"):
		var textDmg = Dmg_label.new()
		textDmg.setText(str(target.total_damage))
		hitted(target.total_damage)
		_atas_kepala.add_child(textDmg)
		



func _on_hp_empty() -> void:   # putar animasi meninggoy
	fsm.transition("death")
