extends Area2D


@onready var player := preload("res://entity/ika-ship/ikaruga.tscn")
var max_range := 500.0
var speed := 900.0

var _travelled_dist = 0.0

func _physics_process(delta: float) -> void:
	var distance := speed * delta
	position += transform.x * speed * delta
	
	_travelled_dist += distance
	if _travelled_dist > max_range:
		queue_free()
	#if transform.distance_to()player.global_transform) > 5000:
		#queue_free()

func _on_body_entered(_body):
	queue_free()


func _on_area_entered(area):
	queue_free()
