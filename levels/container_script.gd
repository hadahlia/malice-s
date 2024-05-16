extends Node2D

@onready var e = find_child("m2")

func _ready():
	e

func _on_slain():
	print("slain triggered")
	#container.remove_child()
	#await get_tree().process_frame
	if get_child_count() == 0:
		get_parent()._spawn_wave()
	else:
		print("there are ", get_child_count(), "children")
		#cur_lvl.spawn_timer.stop()
