extends Area2D

@export var health : int = 420

@export var speed : float = 16.0

var explosion : PackedScene = load("res://levels/effects/explosion_f.tscn")

signal take_hit
signal slain

func _ready():
	pass

func _physics_process(delta: float) -> void:
	position += transform.y * speed * delta

func kill():
	var explosion_instance = explosion.instantiate() as Node2D
	explosion_instance.global_position = global_position
	get_parent().add_child(explosion_instance)
	slain.emit()
	queue_free()

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
