extends Area2D

@onready var timer := $"../DebugLvl/SpawnTimer"
@onready var entest = owner.find_child("m2")

func _ready():
	pass
	#slain.connect(_on_enemy_slain)

func _on_enemy_slain():
	if get_tree().get_nodes_in_group("enemies").size() == 0:
		timer.stop()
