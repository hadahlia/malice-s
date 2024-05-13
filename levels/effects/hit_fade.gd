extends Node2D

@onready var anima_sprite = $hit_fx

func _ready():
	anima_sprite.play("hit_fade")

func _on_hit_fx_animation_finished():
	queue_free()
