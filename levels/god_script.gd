extends Node2D


@export var lives : int = 6

@onready var spawn_pos := $PlrSpawnPos
@onready var respawn_timer := $RespawnTimer
@onready var hud = $HUD
@onready var pause_screen = $PauseScreen
@onready var death_screen = $DeathScreen
@onready var victory_screen = $VictoryScreen
@onready var v_sound = $VictoryScreen/AudioStreamPlayer



@onready var kill_void = %kill_void

var multiplier_inherit : int = 1
#var score : int = 0


#@onready var doggy := $Cammy/Ikaruga
@onready var dog_ship_scene : PackedScene = load("res://entity/ika-ship/ikaruga.tscn")
var ikaruga = null
var paused : bool = false

signal respawn
signal destroyed

signal reload
signal victory
# Called when the node enters the scene tree for the first time.
func _ready():
	hud.score = 0
	spawn_doggy()
	#hud.lives = lives


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	hud.score += int((50 * multiplier_inherit) *  delta)
	#if ikaruga == null:
		#_vibe_check()

func spawn_doggy():
	print("attempting 2 spawn doggy o7")
	var doggy = dog_ship_scene.instantiate() as CharacterBody2D
	doggy.hit.connect(_on_ikaruga_hit)
	doggy.pause.connect(_on_pause)
	doggy.transform = spawn_pos.global_transform
	self.add_child(doggy)
	multiplier_inherit = doggy.score_multiplier
	ikaruga = doggy
	
	hud.lives = lives
	respawn.emit()

func _on_pause():
	if paused:
		pause_screen.hide()
		Engine.time_scale = 1
	else:
		pause_screen.show()
		Engine.time_scale = 0
	paused = !paused

func _vibe_check():
	Global.score_multiplier = 0
	print("the vibe check has counted: ", lives," lives")
	if lives <= 0:
		destroyed.emit()
	else:
		respawn_timer.start()
		print("Timer started!")

func _on_ikaruga_hit():
	print("hit signal connected <3")
	_vibe_check()

func _on_respawn_timer_timeout():
	#print("timer_timeout :D")
	
	#inv_time.start()
	lives -= 1
	hud.score += 6000
	spawn_doggy()

#func _on_inv_timer_timeout():
	#print("inv timer end!")
	#if ikaruga == null:
		#pass
	#else:
		#ikaruga._invincibility_toggle()
	#owner.find_child("doggy").hitbox.show()


func _on_kill_void_area_entered(area):
	area.queue_free()


func _on_destroyed():
	if paused:
		death_screen.hide()
		Engine.time_scale = 1
	else:
		death_screen.show()
		Engine.time_scale = 0
	paused = !paused


func _on_victory():
	victory_screen.show()
	v_sound.play()
