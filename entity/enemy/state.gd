extends Node
class_name State

@onready var debug = owner.find_child("temp")
@onready var player = owner.get_parent().find_child("doggy")
@onready var speed = owner.find_child("FiringSpeed")
@onready var duration = owner.find_child("FiringDuration")

var trans_flag : bool = false

func _ready():
	set_physics_process(false)
	duration.timeout.connect(_on_duration_timeout)

func _on_duration_timeout():
	trans_flag = true

func enter():
	set_physics_process(true)
	trans_flag = false
	duration.start()

func exit():
	set_physics_process(false)

func transition():
	pass

func _physics_process(_delta):
	transition()
	debug.text = name
