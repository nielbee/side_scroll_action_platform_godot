extends State
@onready var death_bringer: EnemyBossDeathbringer = $"../.."
@onready var sprite: AnimatedSprite2D = $"../../sprite"
@onready var fsm: FiniteStateMachine = $".."


func enter()->void:
	await get_tree().create_timer(randf_range(0, 0.4)).timeout
	if death_bringer.distanceToPlayer.x < 0 : death_bringer.flipDeathBringer(false)
	elif death_bringer.distanceToPlayer.x > 0 : death_bringer.flipDeathBringer(true)
	sprite.play("attack")
	await sprite.animation_finished
	fsm.transition("idle")
