extends State

@onready var death_bringer: EnemyBossDeathbringer = $"../.."
@onready var sprite: AnimatedSprite2D = $"../../sprite"
@onready var fsm: FiniteStateMachine = $".."

var nextRandomState := [
	"chase_player",
	"spell"
]


func enter()->void:

	sprite.play("idle")
	await get_tree().create_timer(0.3).timeout
	

func physics_update(delta: float)->void:
	
	if abs(death_bringer.distanceToPlayer.x) <= death_bringer.ATTACK_DISTANCE :
		fsm.transition("attack")
	else:
		fsm.transition("chase_player")
		#
	#if abs(death_bringer.distanceToPlayer.x) > 10:
		#fsm.transition(nextRandomState[randi_range(0,nextRandomState.size()-1)])
