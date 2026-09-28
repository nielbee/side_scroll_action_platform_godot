extends State

@onready var player: Player = $"../.."
@onready var sprite: AnimatedSprite2D = %sprite
@onready var fsm: FiniteStateMachine = %FSM

const GESEKAN := 18

func enter()->void:
	sprite.play("wall_slide")


func physics_update(delta: float)->void:
	player.velocity.y = GESEKAN
	if Input.is_action_just_pressed("move_down"):
		fsm.transition("fall")
	if Input.is_action_just_pressed("jump"):
		fsm.transition("wall_jump")
	if player.is_on_floor():
		fsm.transition("idle")
