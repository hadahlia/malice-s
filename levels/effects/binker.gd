extends Node

@onready var bink_time = $BinkTime
@onready var duration = $Duration
var bink_obj : CharacterBody2D

func start_bink(object, dur):
	bink_obj = object
	#duration.wait_time = dur
	duration.start(dur)
	bink_time.start()

func _on_bink_time_timeout():
	if bink_obj.modulate.a >= 5:
		bink_obj.modulate.a = 0.5
	else:
		bink_obj.modulate.a = 1.0
	#bink_obj.visible = !bink_obj.visible


func _on_duration_timeout():
	bink_time.stop()
	bink_obj.visible = true
