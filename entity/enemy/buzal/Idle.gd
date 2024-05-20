extends State

@onready var collision = %CollisionShape2D


var doggy_entered : bool = false:
	set(value):
		doggy_entered = value
		collision.set_deferred("disabled", value)


func _on_range_area_body_entered(body):
	doggy_entered = true

func transition():
	if doggy_entered:
		get_parent().change_state("Spread")


#func _on_range_area_body_exited(body):
	#pass # Replace with function body.
