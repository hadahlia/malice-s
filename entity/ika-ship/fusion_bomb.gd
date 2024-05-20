extends Area2D

@export var damage : int = 9999
@onready var anima = $AnimationPlayer




func _on_implosion_finished():
	queue_free()


func _on_animation_player_animation_finished(anim_name):
	anima.stop()
	queue_free()
