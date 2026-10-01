extends State
@onready var death_bringer: EnemyBossDeathbringer = $"../.."
@onready var sprite: AnimatedSprite2D = $"../../sprite"
@onready var fsm: FiniteStateMachine = $".."
@onready var sword: CollisionShape2D = $"../../sprite/hitbox/sword"
@onready var hitbox: EnemyHitboxArea2d = $"../../sprite/hitbox"

const ATTACK_FRAME_ACTIVE = 4
const DAMAGE = 2


func enter()->void:
	hitbox.setGivenDamage(DAMAGE)
	#Log.info("ENTER ATTACK STATE")
	if death_bringer.distanceToPlayer.x < 0 : death_bringer.flipDeathBringer(false)
	elif death_bringer.distanceToPlayer.x > 0 : death_bringer.flipDeathBringer(true)
	sprite.play("attack")
	await sprite.animation_finished
	sprite.play("idle")
	await get_tree().create_timer(0.5).timeout
	fsm.transition("idle")

func physics_update(delta: float)->void:
	#Log.info("on attack loop")
	if sprite.frame >= ATTACK_FRAME_ACTIVE :
		sword.disabled = false
	if sprite.frame > ATTACK_FRAME_ACTIVE+1 :  # hitbox aktif 2 frame
		sword.disabled = true
