extends State

@onready var player: Player = $"../.."
@onready var hitbox_shape: CollisionShape2D = $"../../hitbox/hitbox/hitbox_shape"
@onready var sprite: AnimatedSprite2D = %sprite
@onready var fsm: FiniteStateMachine = %FSM
const FORWARD_FORCE = 5
const BASE_DMG = 2
var nextState : String

func enter()->void:
	player.playSound(player.SFX_sword_swing)
	get_tree().create_timer(0.3).timeout.connect(_disableHitbox)
	player.total_damage = BASE_DMG
	player.velocity.x = 0
	player.position.x +=  player.lastDirection*FORWARD_FORCE
	nextState = "idle"
	#await get_tree().create_timer(0.1).timeout
	hitbox_shape.disabled = false
	
	
	sprite.play("melee2")
	await sprite.animation_finished
	fsm.transition(nextState)

func physics_update(delta: float)->void:
	player.move_input = Vector2.ZERO
	if Input.is_action_just_pressed("attack"):
		nextState = "melee3"
	
func exit()->void:
	hitbox_shape.disabled = true

func _disableHitbox()->void:
	hitbox_shape.disabled = true
