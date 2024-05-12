extends Node2D

@onready var anim_sprite = $AnimatedSprite2D

func _ready():
	anim_sprite.play("explode")


#func _process(delta):
	#pass


func _on_animated_sprite_2d_animation_finished():
	queue_free()
