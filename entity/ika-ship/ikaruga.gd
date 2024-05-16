extends CharacterBody2D

@export var speed : int = 200
#@export var friction : float = 0.01
#@export var acceleration : float = 0.1
@export var shot_limit : int = 3


@export var Bullet : PackedScene = load("res://entity/ika-ship/moon_slice.tscn")
#@export var long_b_bullet : PackedScene
#@export var long_r_bullet : PackedScene
#var A_Bullet : PackedScene = load("res://entity/ika-ship/moon_slice_a.tscn")

#var long_blue := load()
@onready var hitbox := $NexusCore
@onready var inv_timer = %InvTimer

@onready var r_sprite = $SpriteA
@onready var b_sprite = $SpriteB
@onready var fire_sfx = $FiringSound

#@onready var viewSpace := get_viewport_rect().size

var explosion : PackedScene = load("res://levels/effects/explosion_f.tscn")
#var bullet_fade : PackedScene = preload("res://levels/effects/hit_fade.tscn")

var shot_count : int
var score : int = 0

var _canFire : bool
var _polarized : bool

var bullet_type : int = 0

signal hit

func _ready():
	print("invincibility autostart")
	_canFire = true
	_polarized = false
	b_sprite.show()
	r_sprite.hide()
	#get_parent().respawn.connect(_invincibility_time)



func get_input():
	var input = Vector2()
	if Input.is_action_pressed('right'):
		input.x += 1
	if Input.is_action_pressed('left'):
		input.x -= 1
	if Input.is_action_pressed('down'):
		input.y += 1
	if Input.is_action_pressed('up'):
		input.y -= 1
	return input

func fire_0():
	var b1 = Bullet.instantiate()
	#var b2 = Bullet.instantiate()
	#var b3 = Bullet.instantiate()
	#b1.animation = "short"
	b1.bullet_freed.connect(_on_bullet_freed)
	#get_parent().add_child(b2)
	#get_parent().add_child(b3)
	get_parent().add_child(b1)
	b1.transform = $Gun0.global_transform
	b1.set_color(bullet_type)
	
	#b2.transform = $Gun1.global_transform
	#b3.transform = $Gun2.global_transform

func fire_lasers():
	var l1 = Bullet.instantiate()
	#l1.animation = "long"
	#l1.short_sprite.hide()
	#l1.long_sprite.show()
	var l2 = Bullet.instantiate()
	#l2.short_sprite.hide()
	#l2.long_sprite.show()
	get_parent().add_child(l1)
	get_parent().add_child(l2)
	l1.transform = $LGun.global_transform
	l2.transform = $RGun.global_transform
	l1.set_color(bullet_type+2)
	l2.set_color(bullet_type+2)

#func spawn_red_s():
	#var c1 = Bullet.instantiate()
	#var c2 = A_Bullet.instantiate()
	#var c3 = A_Bullet.instantiate()
	#get_parent().add_child(c1)
	#get_parent().add_child(c2)
	#get_parent().add_child(c3)
	#c1.bullet_freed.connect(_on_bullet_freed)
	#c1.transform = $Gun0.global_transform
	#c2.transform = $Gun1.global_transform
	#c3.transform = $Gun2.global_transform
#
#func spawn_red_long():
	#var l1 = Bullet.instantiate()
	#l1.animation = "long"
	#l1.short_sprite.hide()
	#l1.long_sprite.show()
	#var l2 = Bullet.instantiate()
	#l2.short_sprite.hide()
	#l2.long_sprite.show()
	#get_parent().add_child(l1)
	#get_parent().add_child(l2)
	#l1.transform = $LGun.global_transform
	#l2.transform = $RGun.global_transform

func fire():
	#if _polarized:
		#bullet_type = 1
		##spawn_red_s()
		##spawn_red_long()
	#else:
		#bullet_type = 0
		##spawn_blue_s()
		##spawn_blue_long()
	fire_0()
	fire_lasers()
	fire_sfx.play()
	#await(get_tree()).create_timer(0.5, true)
	$FireCooldown.start()
	_canFire = false
	shot_count += 1

func _polarization():
	$FireCooldown.start()
	_polarized = !_polarized
	if _polarized:
		bullet_type = 1
		b_sprite.hide()
		r_sprite.show()
	else:
		bullet_type = 0
		r_sprite.hide()
		b_sprite.show()

func _process(delta):
	if Input.is_action_pressed("fire") and _canFire and shot_count < shot_limit:
		fire()
	#elif Input.is_action_pressed("fire") and _canFire and shot_count < shot_limit and _polarized:
		#b_fire()
	if Input.is_action_just_pressed("polarity_switch"):
		_polarization()

func _physics_process(delta):
	var direction = get_input()
	if direction.length() > 0:
		velocity = direction.normalized() * speed
	else:
		velocity = Vector2.ZERO
	move_and_slide()
	
	
	#position.x = clamp(position.x, 0, viewSpace.x)
	#position.y = clamp(position.y, 0, viewSpace.y)


func _on_fire_cooldown_timeout():
	_canFire = true

func death():
	_canFire = false
	var explosion_instance = explosion.instantiate() as Node2D
	explosion_instance.global_position = global_position
	get_parent().add_child(explosion_instance)
	hit.emit()
	queue_free()

func _on_bullet_freed():
	shot_count -= 1

func _on_nexus_core_body_entered(body):
	death()


func _on_nexus_core_area_entered(area):
	if hitbox.is_visible():
		death()
	else:
		print("loser :3")
		pass

func _invincibility_toggle():
	
	if hitbox.is_visible():
		print("invincible!")
		hitbox.hide()
		inv_timer.start()
	else:
		_on_inv_timer_timeout()

func _on_inv_timer_timeout():
	print("inv end")
	hitbox.show()
