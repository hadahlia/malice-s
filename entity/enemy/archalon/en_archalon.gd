extends Area2D

@export var health : int = 420
@export var score_provide : int = 1000
@export var speed : float = 16.0

var theta : float = 0.0
@export_range(0,2*PI) var alpha: float = 0.0

@export var bull_node : PackedScene

@onready var gun := $Gun

var explosion : PackedScene = load("res://levels/effects/explosion_f.tscn")

var bullet_variant : int = 1

signal take_hit
signal slain

func get_vector(angle):
	theta = angle + alpha
	return Vector2(cos(theta), sin(theta))

func shoot(angle):
	var bull = bull_node.instantiate()
	
	bull.position = gun.global_position
	bull.direction = get_vector(angle)
	bull.set_property(bullet_variant)
	
	get_tree().current_scene.call_deferred("add_child", bull)

func _ready():
	pass

func _physics_process(delta: float) -> void:
	position += transform.y * speed * delta

func explode():
	var explosion_instance = explosion.instantiate() as Node2D
	explosion_instance.global_position = global_position
	get_parent().add_child(explosion_instance)

func kill():
	explode()
	#slain.emit()
	#print("slain emitted")
	#get_parent().remove_child(self)
	#remove_child()
	#if score != null:
		#score.score = score_provide
	#Global.temp_score += score_provide
	Global.temp_score += score_provide
	_remove()
	slain.emit()


func _remove():
	queue_free()
	#owner.remove_child(self)
#func _on_body_entered(body):
	#kill()

func take_damage(amount):
	var old_health = health
	health -= amount
	take_hit.emit(old_health, health)
	if health <= 0:
		health = 0
		kill()

#func _on_area_entered(area):
	#take_damage(area.damage)


func _on_hurt_box_area_entered(area):
	take_damage(area.damage)


func _on_firing_speed_timeout():
	shoot(theta)
