extends Node2D

var cur_state : State
var prev_state : State

func _ready():
	cur_state = get_child(0) as State
	prev_state = cur_state
	cur_state.enter()

func change_state(state):
	if state == prev_state.name:
		return
	
	cur_state = find_child(state) as State
	cur_state.enter()
	
	prev_state.exit()
	prev_state = cur_state
