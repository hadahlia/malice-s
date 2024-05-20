extends Node

#var barge : PackedScene = load("res://entity/enemy/archalon/en_archalon.tscn")
#var sheep : PackedScene = load("res://entity/enemy/buzal/en_buzals.tscn")

var barge : PackedScene = load("res://entity/fleets/heavy_path_arch.tscn")
var sheep : PackedScene = load("res://entity/fleets/beizal_popcorn.tscn")

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
			l1,l1,l2,l2,l1,
			#l3,l2,l1, l1, l1
			]
			en_list = [
			barge,barge,barge,barge,barge
			#barge,sheep,barge, sheep, sheep
			]
		1:
			pos_list = [
			l1,l1,l2,l2,l3, #1
			l3,l2,l2, l1, l1, #2
			l1,l2,l2,l3,l2, #3
			l3,l3,l2,l2,l1, #4
			l1,l3,l3,l3,l3, #5
			l2,l2,l2,l2,l1, #6
			l1,l2,l2,l3,l3, #7
			l3,l3,l1,l1,l1, #8
			l3,l3,l2,l2,l1, #9
			l3,l2,l1,l1,l2, #10
			l2,l1,l2, l2, l2, #11
			l1,l1,l1,l1,l1, #12
			l2,l2,l2,l2,l2, #13
			l1,l1,l1,l1,l1, #14
			l1,l1,l1,l1,l1, #15
			l2,l2,l2,l2,l2, #16
			l3,l3,l3,l3,l3, #17
			l2,l2,l2,l2,l1, #18
			l1,l1,l2,l2,l3 #18
			]
			en_list = [
			sheep,sheep,barge,sheep,sheep, #1
			barge,sheep,sheep,sheep,sheep, #2
			barge,sheep,sheep,sheep,sheep, #3
			sheep,barge,barge,sheep,sheep, #4
			barge,sheep,barge,sheep,sheep, #5
			barge,sheep,sheep,barge,sheep, #6
			sheep,sheep,sheep,barge,sheep, #7
			sheep,sheep,sheep,sheep,barge, #8
			barge,sheep,sheep,barge,sheep, #9
			barge, sheep, sheep, sheep,sheep, #10
			barge, barge, barge, sheep,sheep, #11
			sheep,sheep,sheep,barge,sheep, #12
			sheep,sheep,sheep,barge,sheep, #13
			sheep,sheep,sheep,barge,sheep, #14
			sheep,sheep,sheep,barge,sheep, #15
			sheep,sheep,sheep,barge,sheep, #16
			sheep,barge,sheep,barge,barge, #17
			sheep,sheep,sheep,barge,sheep, #18
			sheep,barge,sheep,barge,barge #19
			]
	
	get_parent()._get_data(pos_list, en_list)

func _on_spawn_timer_timeout():
	get_parent()._spawn_wave()
