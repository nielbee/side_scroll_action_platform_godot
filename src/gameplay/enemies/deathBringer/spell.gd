extends State

@onready var death_bringer: EnemyBossDeathbringer = $"../.."
@onready var sprite: AnimatedSprite2D = $"../../sprite"
@onready var fsm: FiniteStateMachine = $".."


func enter()->void:
	sprite.play("cast_spell")
	await sprite.animation_finished
	sprite.play("idle")
	await get_tree().create_timer(randi_range(0.5,1.4)).timeout
	fsm.transition("idle")
