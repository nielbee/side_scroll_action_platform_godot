extends State
@onready var dummy: EnemyBody = $"../.."
@onready var sprite_2d: Sprite2D = $"../../Sprite2D"
@onready var dummy_fsm: FiniteStateMachine = $".."
@onready var upper_point: Node2D = $"../../instantiate_here/upper_point"


func enter()->void:
	var dmg_label := Dmg_label.new()
	upper_point.add_child(dmg_label)
	
	dmg_label.global_position = upper_point.global_position
	
	Log.info(dmg_label.get_glo)
	dmg_label.setText(str(dummy.damage_taken))
	sprite_2d.material.set("shader_parameter/hit_effect",0.3)
	dummy.hitstop(0.7,0.8)
	get_tree().create_timer(0.2).timeout.connect(toNetralState)


func toNetralState()->void:
	sprite_2d.material.set("shader_parameter/hit_effect",0)
	dummy_fsm.transition("netral")
	
