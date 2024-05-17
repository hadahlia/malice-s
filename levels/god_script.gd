extends Node2D


@export var lives : int = 6

@onready var spawn_pos := $PlrSpawnPos
@onready var respawn_timer := $RespawnTimer


@onready var kill_void = %kill_void


#@onready var doggy := $Cammy/Ikaruga
@onready var dog_ship_scene : PackedScene = load("res://entity/ika-ship/ikaruga.tscn")
var ikaruga = null

signal respawn
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
	doggy.transform = spawn_pos.global_transform
	self.add_child(doggy)
	ikaruga = doggy
	
	respawn.emit()

func _vibe_check():
	print("the vibe check has counted: ", lives," lives")
	if lives < 0:
		pass
	else:
		respawn_timer.start()
		print("Timer started!")

func _on_ikaruga_hit():
	print("hit signal connected <3")
	_vibe_check()

func _on_respawn_timer_timeout():
	#print("timer_timeout :D")
	spawn_doggy()
	#inv_time.start()
	lives -= 1

#func _on_inv_timer_timeout():
	#print("inv timer end!")
	#if ikaruga == null:
		#pass
	#else:
		#ikaruga._invincibility_toggle()
	#owner.find_child("doggy").hitbox.show()


func _on_kill_void_area_entered(area):
	area.queue_free()
