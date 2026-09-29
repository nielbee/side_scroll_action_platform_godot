extends State
#di sliding, hurtbox akan dihilangkan sepersekian detikan sehingga saat player slide, 
#musuh tidak bisa memberi damage


@onready var hurtbox_shape: CollisionShape2D = $"../../hurtbox/hurtbox/hurtbox_shape"
@onready var player: Player = $"../.."
@onready var sprite: AnimatedSprite2D = %sprite
@onready var fsm: FiniteStateMachine = %FSM

const IFRAME_DURATION := 0.4
const SPEED_MODIFIER = 2  # 2 kali lebih cepat daripada velocity sebelumnya (lari / run)
func enter()->void:
	player.velocity = player.velocity*SPEED_MODIFIER
	hurtbox_shape.disabled = true
	get_tree().create_timer(IFRAME_DURATION).timeout.connect(func():hurtbox_shape.disabled = false)
	sprite.play("slide")
	await sprite.animation_finished
	fsm.transition("idle")
