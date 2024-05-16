extends Control

@onready var hud : Control = $HUD
@onready var menu : Control = $Menu
@onready var level_select : Control = $Level_Select
@onready var god : Node2D = $God

var level_instance : Node2D

func ready():
	pass

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
		god.add_child(level_instance)


func _on_level_select_pressed():
	level_select.show()
	menu.hide()


func _on_level_1_pressed():
	menu.hide()
	level_select.hide()
	load_level("mission0")
