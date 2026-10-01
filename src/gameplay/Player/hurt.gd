extends State
@onready var player: Player = $"../.."
@onready var sprite: AnimatedSprite2D = %sprite
@onready var fsm: FiniteStateMachine = %FSM

const HIT_EFFECT := 0.22
func enter()->void:
	#player.take_damage()  / sudah take damage di parent
	sprite.play("hurt")
	sprite.material.set("shader_parameter/hit_effect",HIT_EFFECT)
	await sprite.animation_finished
	sprite.material.set("shader_parameter/hit_effect",0)
	await get_tree().create_timer(0.2).timeout
	fsm.transition("idle")
