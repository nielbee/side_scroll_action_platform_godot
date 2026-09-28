extends State
@onready var player: Player = $"../.."
@onready var hitbox_shape: CollisionShape2D = $"../../hitbox/hitbox/hitbox_shape"
@onready var sprite: AnimatedSprite2D = %sprite
@onready var fsm: FiniteStateMachine = %FSM
const BASE_DMG := 5
const FORWARD_FORCE := 12


func enter()->void:
	player.playSound(player.SFX_sword_swing)
	player.total_damage = BASE_DMG
	player.velocity.x = player.lastDirection*FORWARD_FORCE
	get_tree().create_timer(0.2).timeout.connect(func()->void:hitbox_shape.disabled = false ) # tggu sedikit untuk nyalakan sa
	get_tree().create_timer(0.3).timeout.connect(_disableHitbox)
	sprite.play("melee3")
	await sprite.animation_finished
	fsm.transition("idle")

func physics_update(delta: float)->void:
	pass
	
func exit()->void:
	pass
	
	
func _disableHitbox()->void:
	hitbox_shape.disabled = true
