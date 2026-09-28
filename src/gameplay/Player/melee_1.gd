extends State
@onready var hitbox_shape: CollisionShape2D = $"../../hitbox/hitbox/hitbox_shape"
@onready var player: Player = $"../.."
@onready var sprite: AnimatedSprite2D = %sprite
@onready var fsm: FiniteStateMachine = %FSM
const BASE_DMG = 2
const FORWARD_FORCE = 3

var nextState: String

func enter()->void:
	player.playSound(player.SFX_sword_collided)
	player.total_damage = BASE_DMG
	nextState = "idle"
	get_tree().create_timer(0.3).timeout.connect(_disableHitbox)
	player.position.x +=  player.lastDirection*FORWARD_FORCE
	sprite.play("melee1")
	get_tree().create_timer(0.2).timeout.connect(func():hitbox_shape.disabled = false)
	await sprite.animation_finished
	fsm.transition(nextState)
	
	
	
func physics_update(delta: float)->void:
	
	#player.move_input = Vector2.ZERO
	player.velocity.x = 0
	if Input.is_action_just_pressed("attack"):
		#fsm.transition("melee2")
		nextState = "melee2"



func exit()->void:
	hitbox_shape.disabled = true

func _disableHitbox()->void:
	hitbox_shape.disabled = true
