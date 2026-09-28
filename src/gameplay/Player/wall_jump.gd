extends State

@onready var player: Player = $"../.."
@onready var sprite: AnimatedSprite2D = %sprite
@onready var fsm: FiniteStateMachine = %FSM

const H_FORCE = 300
const V_FORCE = 300
func enter()->void:
	sprite.play("jump_loop")
	var directionX = player.get_wall_normal().x
	player.velocity.x = directionX*H_FORCE
	player.velocity.y = -V_FORCE


func physics_update(delta: float)->void:
	if player.is_on_floor():
		fsm.transition("idle")
	if player.is_on_wall() and sign(player.move_input) == -player.get_wall_normal():
		fsm.transition("wall_slide")
