extends AudioStreamPlayer2D

var last_pitch : float = 1.0

#@warning_ignore("native_method_override") 
func r_play(from_position = 0.0):
	
	randomize()
	pitch_scale = randf_range(0.8, 1.1)
	
	while abs(pitch_scale - last_pitch) < .1:
		randomize()
		pitch_scale = randf_range(0.8, 1.2)
	
	last_pitch = pitch_scale
	
	play(from_position)
