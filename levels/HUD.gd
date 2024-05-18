extends Control
class_name UI

@onready var lives_label = %Lives
@onready var score_label = %Score


var lives = 0:
	set(new_lives):
		lives = new_lives
		_update_lives_label()
		
func _update_lives_label():
	lives_label.text = "LIFE : " + str(lives)

var score = 0:
	set(new_score):
		score = new_score + (Global.temp_score * Global.score_multiplier)
		Global.temp_score = 0
		_update_score_label()
		
func _update_score_label():
	score_label.text = "SCORE : " + str(score)
