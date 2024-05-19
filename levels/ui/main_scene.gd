extends Control

@onready var hud : Control = $HUD
@onready var menu : Control = $Menu
@onready var level_select : Control = $Level_Select
@onready var god : Node2D = $God
@onready var select_sound = $SelectSound


var level_instance : Node2D

func ready():
	menu.show()
	level_select.hide()

func unload_level():
	if(is_instance_valid(level_instance)):
		level_instance.queue_free()
	level_instance = null

func load_level(level_name: String):
	unload_level()
	var level_path := "res://levels/%s.tscn" % level_name
	var level_resource := load(level_path)
	if level_resource:
		level_instance = level_resource.instantiate()
		level_instance.reload.connect(_on_reload_received)
		god.add_child(level_instance)

func level_selection(g_id):
	select_sound.play()
	menu.hide()
	level_select.hide()
	Global.level_id = g_id
	load_level("mission0")

func _on_level_select_pressed():
	select_sound.play()
	level_select.show()
	menu.hide()


func _on_level_1_pressed():
	level_selection(1)
	
	#hud.show()


func _on_return_btn_pressed():
	select_sound.play()
	menu.show()
	level_select.hide()


func _on_debug_btn_pressed():
	level_selection(0)

func _on_reload_received():
	level_selection(Global.level_id)
