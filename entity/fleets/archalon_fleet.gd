extends Node2D

@export var speed : int = 65

@onready var path = get_parent()

func follow(delta):
	path.progress += speed * delta

func _physics_process(delta):
	follow(delta)
