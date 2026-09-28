extends CharacterBody2D
class_name Player



const FALL_SPEED := 20.0
const RUN_SPEED:= 80.0
const JUMP_FORCE := 250.0
@onready var hitbox: Node2D = $hitbox
@onready var sprite: AnimatedSprite2D = %sprite
@onready var camera_2d: Camera2D = $Camera2D
const SFX_sword_swing = preload("res://assets/sfx/sword_swing.wav")
const SFX_sword_collided = preload("res://assets/sfx/sword_collided.wav")


var move_input : Vector2 = Vector2.ZERO
var lastDirection := 1.0
var total_damage := 0.0

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
		camera_2d.set_shake(0.1 * (total_damage/ 0.2) ,0.5)
