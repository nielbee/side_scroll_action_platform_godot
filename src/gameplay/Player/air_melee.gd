extends State
@onready var sprite: AnimatedSprite2D = %sprite
@onready var player: Player = $"../.."
@onready var fsm: FiniteStateMachine = %FSM

func enter()->void:
	player.velocity.y -= 200
	sprite.play("melee_air_down_start")
	await sprite.animation_finished
	sprite.play("melee_air_down_loop")
	
func physics_update(delta: float)->void:
	player.velocity.x = 0
	if player.is_on_floor():
		sprite.play("melee_air_down_landing")
		await sprite.animation_finished
		fsm.transition("idle")
