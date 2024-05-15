extends Area2D

@export var damage : int = 10
@export var max_range := 2000.0
@export var speed := 920.0

@onready var player := load("res://entity/ika-ship/ikaruga.tscn")

var _travelled_dist = 0.0

var bullet_fade : PackedScene = load("res://levels/effects/hit_fade.tscn")

signal bullet_freed

func _physics_process(delta: float) -> void:
	var distance := speed * delta
	position += transform.x * speed * delta
	
	#_travelled_dist += distance
	#if _travelled_dist > max_range:
		#queue_free()
	#if transform.distance_to()player.global_transform) > 5000:
		#queue_free()

func hit_effect():
	bullet_freed.emit()
	queue_free()
	
	var hit_f1 := bullet_fade.instantiate()
	hit_f1.position = global_position
	get_parent().add_child(hit_f1)

func _on_body_entered(_body):
	bullet_freed.emit()
	queue_free()


func _on_area_entered(area):
	#area.health -= damage
	hit_effect()
