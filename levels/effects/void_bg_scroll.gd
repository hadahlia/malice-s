extends ParallaxBackground

@onready var space_layer = %SpaceLayer
@onready var star_layer = %StarLayer


func _process(delta: float) -> void:
	space_layer.motion_offset.y += 60 * delta
	#star_layer.motion_offset.y += 18 * delta
