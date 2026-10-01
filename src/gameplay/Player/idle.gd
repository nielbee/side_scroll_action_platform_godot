extends State
@onready var player: Player = $"../.."
@onready var sprite: AnimatedSprite2D = %sprite
@onready var fsm: FiniteStateMachine = %FSM


func enter()->void:
	sprite.material.set("shader_parameter/hit_effect",0)
	player.velocity.x = 0
	sprite.play("idle")


func physics_update(delta: float)->void:
	#player.velocity.y = 0
	if player.move_input.x != 0:
		fsm.transition("run")
	if Input.is_action_just_pressed("attack"):
		fsm.transition("melee1")
	if player.is_on_floor() and Input.is_action_just_pressed("jump"):
		fsm.transition("jump")
	if not player.is_on_floor():
		fsm.transition("fall")
