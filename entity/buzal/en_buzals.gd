extends Area2D

var explosion : PackedScene = preload("res://levels/effects/explosion_f.tscn")

signal slain

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func kill():
	var explosion_instance = explosion.instantiate() as Node2D
	explosion_instance.global_position = global_position
	get_parent().add_child(explosion_instance)
	slain.emit()
	queue_free()

#func _on_body_entered(body):
	#kill()

func _on_area_entered(area):
	kill()
