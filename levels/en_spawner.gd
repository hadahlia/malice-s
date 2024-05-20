extends Node2D

#@export var level_id : int = 0

#@onready var spawn_timer := $FallbackTimer
#@onready var l1 := $LaneL
#@onready var l2 := $LaneM
#@onready var l3 := $LaneR
#@onready var pos_list : Array[Marker2D]
@onready var container := $Container
#@onready var h_1 = $Container/HeavyPath/H_1

var wave_num : int = 0
var cur_lvl : Node2D

#var p_list : Array[Marker2D] = []
#var e_list : Array[PackedScene] = []
#var en_list : Array[PackedScene] = [sheep, sheep, barge]
@onready var p : Array[Marker2D]
var e : Array[PackedScene]

func _ready():
	cur_lvl = get_child(0)
	#spawn_timer.start()
	cur_lvl._set_level_data()


func _process(delta):
	if get_tree().has_group("enemies") == false and wave_num < p.size():
		print("FINALLY")
		#cur_lvl.spawn_timer.stop()
		_spawn_wave()

func _get_data(pos_list, en_list):
	p = pos_list
	e = en_list
	_spawn_wave()
	#spawn_timer.start()

func _spawn_wave():
	
	if wave_num < p.size():
		#for i in pos_list.size():
			#pass
		print("spawning wave!")
		var m1 = e[wave_num]
		var m2 = m1.instantiate()
		var p1 = p[wave_num]
		#get_parent().add_child(m1)
		m2.transform = p1.global_transform
		#m2.slain.connect(_on_slain)
		container.add_child(m2)
		wave_num += 1
		cur_lvl.spawn_timer.start()
	else:
		print("max wave reached! freeing timer...")
		if cur_lvl.spawn_timer != null:
			cur_lvl.spawn_timer.queue_free()
		#owner.victory.emit()
		#spawn_timer.queue_free()
		#IMPLEMENT BOSS WAVE LOGIC?

#		SPAWN TIMER FUNCTION
#func _on_fallback_timer_timeout():
	#_spawn_wave()


#func _on_container_child_exiting_tree(node):
	#if container.get_child_count() == 0:
		#cur_lvl.spawn_timer.stop()
	#else: pass


#func _on_slain():
	#print("slain triggered")
	#Global.score_multiplier += 1
	#await get_tree().create_timer(0.15).timeout
	#if get_tree().has_group("enemies") == false:
		#print("FINALLY")
		#_spawn_wave()
