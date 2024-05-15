extends Node2D

var barge := load("res://entity/enemy/archalon/en_archalon.tscn")
var sheep := load("res://entity/enemy/buzal/en_buzals.tscn")

@onready var spawn_timer := $FallbackTimer

@onready var lane_1 := $LaneL
@onready var lane_2 := $LaneM
@onready var lane_3 := $LaneR

var wave_num : int = 0
@onready var pos_list := [lane_1, lane_2, lane_3]
var spawns_list := [sheep, sheep, barge]

func _ready():
	pass

func _process(delta):
	pass

func _spawn_next_wave():
	print("spawning wave!")
	pass
	var m1 = spawns_list[wave_num]
	var m2 : Area2D = m1.instantiate()
	var p1 = pos_list[wave_num]
	#get_parent().add_child(m1)
	m2.transform = p1.global_transform
	get_parent().add_child(m2)
	wave_num += 1

func _on_fallback_timer_timeout():
	if wave_num < spawns_list.size():
		_spawn_next_wave()
	else:
		spawn_timer.queue_free()
