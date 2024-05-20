extends Path2D

@export var speed = 60

@onready var h_1 = get_node("H_1")

func _process(delta):
	h_1.set_offset(h_1.get_offset() + speed * delta)
