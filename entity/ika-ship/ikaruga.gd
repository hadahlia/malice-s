extends CharacterBody2D

@export var speed : int = 200
#@export var friction : float = 0.01
#@export var acceleration : float = 0.1
@export var shot_limit : int = 3
@export var heat_limit : int
@export var heat_coeff : float = 0.55
@export var Bullet : PackedScene = load("res://entity/projectile/moon_slice.tscn")
@export var multiplier : float

@export var score_multiplier : int = 1

@onready var hitbox := $NexusCore
@onready var inv_timer = %InvTimer
@onready var vent_delay = $VentDelay
@onready var heat_bar = $HeatBar

@onready var sprite_t := $SpriteT


@onready var fire_sfx = $FiringSound

#@onready var viewSpace := get_viewport_rect().size

var explosion : PackedScene = load("res://levels/effects/explosion_f.tscn")
#var bullet_fade : PackedScene = preload("res://levels/effects/hit_fade.tscn")

var shot_count : int
#var score : int = 0
var heat : int = 0
var bullet_type : int = 0
var _canFire : bool

var vent : bool = false

signal hit

func _ready():
	#print("invincibility autostart")
	_canFire = true
	hitbox.hide()
	heat_bar._init_heat(heat, heat_limit)
	heat_bar.hide()

func fire_0():
	var b1 = Bullet.instantiate()
	
	b1.bullet_freed.connect(_on_bullet_freed)
	
	get_parent().add_child(b1)
	
	b1.transform = $Gun0.global_transform
	
	#b1.set_color(bullet_type)
	var heat_mul = heat * multiplier
	b1.damage += heat_mul
	
	print("DAMAGE: ",b1.damage)

func devil_fire():
	var b2 = Bullet.instantiate()
	var b3 = Bullet.instantiate()
	b2.bullet_freed.connect(_on_bullet_freed)
	b3.bullet_freed.connect(_on_bullet_freed)
	get_parent().add_child(b2)
	get_parent().add_child(b3)
	b2.transform = $Gun1.global_transform
	b3.transform = $Gun2.global_transform
	var scale_var = Vector2(0.8, 1.0)
	b2.scale = scale_var
	b3.scale = scale_var
	var heat_mul = heat * multiplier
	b2.damage += heat_mul
	b3.damage += heat_mul
	
func fire_lasers():
	var l1 = Bullet.instantiate()
	var l2 = Bullet.instantiate()
	get_parent().add_child(l1)
	get_parent().add_child(l2)
	l1.transform = $LGun.global_transform
	l2.transform = $RGun.global_transform
	#l1.set_color(bullet_type+2)
	#l2.set_color(bullet_type+2)
	var heat_mul = heat * multiplier
	l1.damage += heat * multiplier
	l2.damage += heat * multiplier

func fire():
	if heat <= heat_limit:
		if heat > heat_limit * heat_coeff:
			#multiplier = multiplier * 1.3
			devil_fire()
		#print("shot limit: ", shot_limit)
		fire_0()
		fire_lasers()
		fire_sfx.play()
		#await(get_tree()).create_timer(0.5, true)
		$FireCooldown.start()
		vent_delay.start()
		heat_bar.show()
		vent = false
		_canFire = false
		shot_count += 1
		
		heat += 11
		
		heat_bar.heat = heat
		#shot_limit = heat % heat_limit
	else:
		
		hyperfusion_bomb()

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

func _process(delta):
	
	if Input.is_action_pressed("fire") and _canFire and shot_count < shot_limit:
		fire()
		
	if vent and heat > 0:
		#print(heat)
		heat -= 185 * delta
		heat_bar.heat = heat
	#elif Input.is_action_pressed("fire") and _canFire and shot_count < shot_limit and _polarized:
		#b_fire()
	#if Input.is_action_just_pressed("polarity_switch"):
		#_polarization()

func _physics_process(delta):
	var direction = get_input()
	var hor_direction = Input.get_axis("left", "right")
	if direction.length() > 0:
		velocity = direction.normalized() * speed
	else:
		#if sprite_t.get_frame() != 0:
			#sprite_t.play_backwards("tilt")
		#else:
			#sprite_t.stop()
		velocity = Vector2.ZERO
	
	
	if hor_direction != 0:
		switch_dir(hor_direction)
		update_anims(hor_direction)
		hor_direction = 0
	elif sprite_t.is_playing() or sprite_t.get_frame() != 0:
		#if sprite_t.is_playing() or sprite_t.get_frame() == 5:
		sprite_t.play_backwards("new_tilt")
	
	move_and_slide()
	

func update_anims(hor_direction):
	if sprite_t.get_frame() == 0 and !sprite_t.is_playing():
		sprite_t.play("new_tilt")

func switch_dir(hor_direction):
	if sprite_t.get_frame() == 0:
		sprite_t.flip_h = (hor_direction == -1)

func _on_fire_cooldown_timeout():
	_canFire = true

func hyperfusion_bomb():
	heat_bar.heat = heat_limit
	death() #lol

func death():
	heat_bar.hide()
	_canFire = false
	var explosion_instance = explosion.instantiate() as Node2D
	explosion_instance.global_position = global_position
	get_parent().add_child(explosion_instance)
	hit.emit()
	queue_free()

func _on_bullet_freed():
	if shot_count > 0:
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


#func _on_sprite_t_animation_finished():
	#sprite_t.pause()


func _on_vent_delay_timeout():
	heat_bar.show()
	vent = true
