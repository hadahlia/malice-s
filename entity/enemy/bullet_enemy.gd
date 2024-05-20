extends Area2D

@export var texture_array : Array[Texture2D]

@export var speed : int = 100
var direction : Vector2 = Vector2.DOWN
var bullet_variant : int = 0

func _physics_process(delta):
	position += direction * speed * delta
	rotation = direction.angle()

func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()

func set_property(type):
	bullet_variant = type
	$Sprite2D.texture = texture_array[type]
