extends State

@onready var colisia = %colisia



var dog_entr : bool = false:
	set(value):
		dog_entr = value
		colisia.set_deferred("disabled", value)

func enter():
	super.enter()
	owner.alpha = 3
	speed.start()


func _on_threshold_range_body_entered(body):
	dog_entr = true
	colisia.set_deferred("enabled", dog_entr)

func transition():
	if dog_entr:
		get_parent().change_state("Idle")
