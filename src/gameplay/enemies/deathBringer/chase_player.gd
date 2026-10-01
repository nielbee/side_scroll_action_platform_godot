extends State
@onready var death_bringer: EnemyBossDeathbringer = $"../.."
@onready var sprite: AnimatedSprite2D = $"../../sprite"
@onready var fsm: FiniteStateMachine = $".."

var randomAction := [
	"chase_player","spell"
]

const WALK_SPEED := 20.0

var dir : int
func enter()->void:
	sprite.play("walk")
	

func physics_update(delta: float)->void:
	death_bringer.velocity.x = sign(death_bringer.distanceToPlayer.x)*WALK_SPEED
	death_bringer.move_and_slide()
	
	if abs(death_bringer.distanceToPlayer.x) <= death_bringer.ATTACK_DISTANCE:
		fsm.transition("idle")   # <-singgah idle dulu, untuk sementaara beberapa pengecekan saya pakai di idle
	
	
	if death_bringer.distanceToPlayer.x < 0 : death_bringer.flipDeathBringer(false)
	elif death_bringer.distanceToPlayer.x > 0 : death_bringer.flipDeathBringer(true)
	
	#if abs(death_bringer.distanceToPlayer.x) > 40 :
		##mungkin pakai persentase???
		#var percent := randi_range(0,300)
		#if percent < 3 :
			#fsm.transition("spell")
			#
