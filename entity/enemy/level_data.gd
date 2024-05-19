extends Node

var barge : PackedScene = load("res://entity/enemy/archalon/en_archalon.tscn")
var sheep : PackedScene = load("res://entity/enemy/buzal/en_buzals.tscn")

var l_rock0 : PackedScene = load("res://entity/rocks/big_boulder.tscn")

#@export var level_id : int

var en_list : Array[PackedScene]

@onready var spawn_timer := $SpawnTimer

@onready var l1 = owner.find_child("LaneL") 
@onready var l2 = owner.find_child("LaneM") 
@onready var l3 = owner.find_child("LaneR") 
#@onready var level_data = get_child(Global.level_id)
@onready var pos_list : Array[Marker2D]
#@onready var en_list : Array[PackedScene]

func _set_level_data():
	#var call = get_child(Global.level_id)
	match Global.level_id:
		0:
			pos_list = [
			l1,l1,l3,l2,l3,
			l3,l2,l1, l1, l1
			]
			en_list = [
			l_rock0,barge,barge,sheep,sheep,
			barge,sheep,barge, sheep, sheep
			]
		1:
			pos_list = [
			l3,l2,l1,l2,l3,
			l3,l2,l1, l1, l1
			]
			en_list = [
			barge,barge,barge,sheep,sheep,
			barge,sheep,barge,sheep, sheep
			]
	
	get_parent()._get_data(pos_list, en_list)

func _on_spawn_timer_timeout():
	get_parent()._spawn_wave()
