extends Area2D

@export var speed : int = 100
var direction : Vector2 = Vector2.RIGHT

func _physics_process(delta):
	position += direction * speed * delta

func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
