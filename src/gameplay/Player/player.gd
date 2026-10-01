extends CharacterBody2D
class_name Player


@export var playerHP := 10.0




@onready var hitbox: Node2D = $hitbox
@onready var sprite: AnimatedSprite2D = %sprite
@onready var camera_2d: Camera2D = $Camera2D
@onready var fsm: FiniteStateMachine = %FSM


const FALL_SPEED := 20.0
const RUN_SPEED:= 80.0
const JUMP_FORCE := 250.0
const SFX_sword_swing = preload("res://assets/sfx/sword_swing.wav")
const SFX_sword_collided = preload("res://assets/sfx/sword_collided.wav")


var move_input : Vector2 = Vector2.ZERO
var lastDirection := 1.0
var total_damage := 0.0



#getter()

func get_player_phantom_cam()->PhantomCamera2D:
	return $PhantomCamera
func get_player_state_machine()->FiniteStateMachine:
	return %FSM

#end of getter

func _physics_process(delta: float) -> void:
	move_input.x = Input.get_axis("move_left","move_right")
	_setLastDir()
	move_and_slide()
	if !is_on_floor():
		_gravity()
	
	

func playSound(preloadedSound : Resource)->void:
	var sound : = AudioStreamPlayer2D.new()
	sound.stream = SFX_sword_collided
	add_child(sound)
	#sound.pitch_scale = randf_range(0.6,1)
	sound.play()
	sound.finished.connect(func()->void: sound.queue_free())



func fall()->void:
	velocity.y -= FALL_SPEED

func _gravity():
	velocity.y += FALL_SPEED

func flip_player()->bool:
	if (move_input.x < 0):
		sprite.flip_h = true
		hitbox.scale.x = -1
		return true
	elif (move_input.x > 0):
		sprite.flip_h = false
		hitbox.scale.x = 1
	return false


func screen_shake()->void:
	pass

func _setLastDir():
	if move_input.x != 0:
		lastDirection = sign(move_input.x)


func _hitting_enemy(area: Area2D) -> void:
	if area.owner is EnemyBody:
		#playSound(sword_collided)
		#camera_2d.set_shake(0.1 * (total_damage/ 0.2) ,0.5)
		pass


func _take_damage(damage: float)->void:
	playerHP-=damage
	if playerHP < 1:
		fsm.transition("death")


func _on_hurtbox_area_entered(area: EnemyHitboxArea2d) -> void:   # deteksi hit dari enemy
	if area.is_in_group("enemy_hitbox"):
		#Log.info(area.givenDamage)
		_take_damage(area.givenDamage)
		fsm.transition("hurt")
