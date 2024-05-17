extends ProgressBar

var heat = 0 : set = _set_heat

func _set_heat(new_heat):
	heat = min(max_value, new_heat)
	value = heat

func _init_heat(_heat, _max_heat):
	heat = _heat
	max_value = _max_heat
	value = heat
