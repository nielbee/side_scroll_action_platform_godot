extends State
#di sliding, hurtbox akan dihilangkan sepersekian detikan sehingga saat player slide, 
#musuh tidak bisa memberi damage


@onready var hurtbox_shape: CollisionShape2D = $"../../hurtbox/hurtbox/hurtbox_shape"
@onready var player: Player = $"../.."
@onready var sprite: AnimatedSprite2D = %sprite
@onready var fsm: FiniteStateMachine = %FSM
@onready var bottom: Node2D = $"../../instantiating_places/bottom"

const DASH_DUST  = preload("res://src/gameplay/GFX/dash_dust.tscn")

const IFRAME_DURATION := 0.4
const SPEED_MODIFIER = 2  # 2 kali lebih cepat daripada velocity sebelumnya (lari / run)
func enter()->void:
	
	var dashDush := DASH_DUST.instantiate()
	var fllipped := player.flip_player()
	if fllipped:dashDush.scale.x = -1
	else : dashDush.scale.x = 1
	var instantiateLocation : Vector2 = bottom.global_position
	add_child(dashDush)
	dashDush.play("dash_dush")
	dashDush.animation_finished.connect(func()->void : dashDush.queue_free())
	dashDush.global_position = instantiateLocation
		
	player.velocity = player.velocity*SPEED_MODIFIER
	hurtbox_shape.disabled = true
	get_tree().create_timer(IFRAME_DURATION).timeout.connect(func():hurtbox_shape.disabled = false)
	sprite.play("slide")
	await sprite.animation_finished
	fsm.transition("idle")
