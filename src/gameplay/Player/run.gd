extends State
@onready var player: Player = $"../.."
@onready var sprite: AnimatedSprite2D = %sprite
@onready var fsm: FiniteStateMachine = %FSM
@onready var hitbox: Node2D = $"../../hitbox"
@onready var bottom: Node2D = $"../../instantiating_places/bottom"


#const DASH_DUST  = preload("res://src/gameplay/GFX/dash_dust.tscn")


func enter()->void:
	sprite.play("run")


func physics_update(delta: float)->void:
	player.velocity.x = player.move_input.x*player.RUN_SPEED
	player.flip_player()
	if player.move_input.x == 0:
		fsm.transition("idle")
	if Input.is_action_just_pressed("attack"):
		fsm.transition("melee1")
	if Input.is_action_just_pressed("jump"):
		fsm.transition("jump")
