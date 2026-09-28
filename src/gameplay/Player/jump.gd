extends State
@onready var player: Player = $"../.."
@onready var sprite: AnimatedSprite2D = %sprite
@onready var fsm: FiniteStateMachine = %FSM

const ADDITIONAL_FORCE_WHEN_HOLD_JUMP = 14.0
const TIME = 0.4

const H_FORCE := 100

var onTime := true

func enter()->void:
	onTime = true
	get_tree().create_timer(TIME).timeout.connect(func():onTime = false)
	sprite.play("jump")
	player.velocity.y -= player.JUMP_FORCE
	await sprite.animation_finished
	fsm.transition("fall")

func physics_update(delta: float)->void:
	player.velocity.x = player.move_input.x * H_FORCE
	if onTime and Input.is_action_pressed("jump"):
		player.velocity.y -= ADDITIONAL_FORCE_WHEN_HOLD_JUMP
	if Input.is_action_just_pressed("attack"):
		fsm.transition("air_melee")
	player.flip_player()
