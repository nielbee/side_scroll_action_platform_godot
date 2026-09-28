extends EnemyBody

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var mid_point: Node2D = $instantiate_here/mid_point
@onready var dummy: EnemyBody = $"."
@onready var dummy_fsm: FiniteStateMachine = $dummy_fsm
@onready var dmg_label: Label = $dmgLabel
const HIT_PARTICLE = preload("uid://c8w1wh8n87h4o")

@onready var damage_taken : float =0

func _ready() -> void:
	#HP_EMPTY.connect(func()->void : queue_free())
	pass


func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_hitbox") and area.owner is Player:
		damage_taken = area.owner.total_damage
		dummy_fsm.transition("hitted")

func _physics_process(delta: float) -> void:
	move_and_slide()
