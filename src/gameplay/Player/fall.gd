extends State

@onready var player: Player = $"../.."
@onready var sprite: AnimatedSprite2D = %sprite
@onready var fsm: FiniteStateMachine = %FSM


func enter()->void:
	sprite.play("jump_loop")



func physics_update(delta: float)->void:
	if player.is_on_floor():
		fsm.transition("idle")
