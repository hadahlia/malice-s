extends State

@onready var colice = %colice



var dog_entr : bool = false:
	set(value):
		dog_entr = value
		colice.set_deferred("disabled", value)

func enter():
	super.enter()
	owner.alpha = 0.3
	speed.start()


func _on_threshold_range_body_entered(body):
	dog_entr = true

func transition():
	if dog_entr:
		get_parent().change_state("Idle")
