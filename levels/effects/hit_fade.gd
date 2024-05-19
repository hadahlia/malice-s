extends Node2D

@onready var anima_sprite = $hit_fx
@onready var audio_s = $AudioStreamPlayer2D


func _ready():
	anima_sprite.play("hit_fade")
	audio_s.r_play()

func _on_hit_fx_animation_finished():
	queue_free()
