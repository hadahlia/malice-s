extends CharacterBody2D

@export var speed : int = 200
@export var friction : float = 0.01
@export var acceleration : float = 0.1

@export var Bullet : PackedScene

var explosion : PackedScene = load("res://levels/effects/explosion_f.tscn")
#var bullet_fade : PackedScene = preload("res://levels/effects/hit_fade.tscn")

@onready var viewSpace := get_viewport_rect().size
var score : int = 0

var _canFire : bool = true
var _polarized : bool

signal hit

#func _ready():
	#pass



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

func b_fire():
	var b1 = Bullet.instantiate()
	var b2 = Bullet.instantiate()
	var b3 = Bullet.instantiate()
	owner.add_child(b1)
	owner.add_child(b2)
	owner.add_child(b3)
	b1.transform = $Gun0.global_transform
	b2.transform = $Gun1.global_transform
	b3.transform = $Gun2.global_transform
	#await(get_tree()).create_timer(0.5, true)
	$FireCooldown.start()
	_canFire = false

func _process(delta):
	if Input.is_action_pressed("fire") and _canFire:
		b_fire()
	if Input.is_action_just_pressed("polarity_switch"):
		!_polarized
	

func _physics_process(delta):
	var direction = get_input()
	if direction.length() > 0:
		velocity = velocity.lerp(direction.normalized() * speed, acceleration)
	else:
		velocity = velocity.lerp(Vector2.ZERO, friction)
	move_and_slide()
	
	
	position.x = clamp(position.x, 0, viewSpace.x)
	position.y = clamp(position.y, 0, viewSpace.y)


func _on_fire_cooldown_timeout():
	_canFire = true

func death():
	var explosion_instance = explosion.instantiate() as Node2D
	explosion_instance.global_position = global_position
	get_parent().add_child(explosion_instance)
	hit.emit()
	queue_free()

func _on_nexus_core_body_entered(body):
	death()


func _on_nexus_core_area_entered(area):
	death()
