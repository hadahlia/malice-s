extends Control

@onready var mission_0 = $".."


#signal reload

func _on_cont_btn_pressed():
	mission_0._on_pause()
	owner.reload.emit()


func _on_quit_btn_2_pressed():
	mission_0._on_pause()
	get_tree().reload_current_scene()
