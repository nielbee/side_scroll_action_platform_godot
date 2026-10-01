extends State

@onready var death_bringer: EnemyBossDeathbringer = $"../.."
@onready var sprite: AnimatedSprite2D = $"../../sprite"
@onready var fsm: FiniteStateMachine = $".."




func enter()->void:
	sprite.play("idle")
	await get_tree().create_timer(0.3).timeout


func physics_update(delta: float)->void:
	
	#Log.info(death_bringer.distanceToPlayer)
	
	if abs(death_bringer.distanceToPlayer.x) <= death_bringer.ATTACK_DISTANCE :
		fsm.transition("attack")
	else:
		fsm.transition("chase_player")
