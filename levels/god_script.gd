extends Node2D


@export var lives : int = 6

#@onready var doggy := $Cammy/Ikaruga
@onready var dog_ship_scene : PackedScene = load("res://entity/ika-ship/ikaruga.tscn")
var ikaruga = null
# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_doggy()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#if ikaruga == null:
		#_vibe_check()

func spawn_doggy():
	print("attempting 2 spawn doggy o7")
	var doggy = dog_ship_scene.instantiate() as CharacterBody2D
	doggy.hit.connect(_on_ikaruga_hit)
	doggy.transform = $PlrSpawnPos.global_transform
	self.add_child(doggy)
	
	ikaruga = doggy

func _vibe_check():
	print("the vibe check has counted: ", lives, "lives")
	if lives < 0:
		pass
	else:
		$RespawnTimer.start()
		print("Timer started!")

func _on_ikaruga_hit():
	print("hit signal connected <3")
	_vibe_check()

func _on_respawn_timer_timeout():
	print("timer_timeout :D")
	spawn_doggy()
	lives -= 1
