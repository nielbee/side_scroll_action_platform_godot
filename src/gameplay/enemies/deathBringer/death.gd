extends State
@onready var death_bringer: EnemyBossDeathbringer = $"../.."
@onready var sprite: AnimatedSprite2D = $"../../sprite"
@onready var fsm: FiniteStateMachine = $".."

func enter()->void:
		death_bringer.velocity = Vector2.ZERO
		sprite.play("hide")
		fsm.disabled = true
		await sprite.animation_finished
		death_bringer.queue_free()
	
