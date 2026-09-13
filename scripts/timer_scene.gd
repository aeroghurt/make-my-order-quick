extends Node2D


@onready var life_container: HBoxContainer = $background/lifeContainer
@onready var life1: TextureRect = $background/lifeContainer/life1
@onready var life2: TextureRect = $background/lifeContainer/life1
@onready var life3: TextureRect = $background/lifeContainer/life2
@onready var life4: TextureRect = $background/lifeContainer/life3
@onready var life5: TextureRect = $background/lifeContainer/life4
@onready var level: RichTextLabel = $level
@onready var timer: RichTextLabel = $timer


var time

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await Timer(5.0)
	
	if (Global.minigames_done < 3):
		Global.minigames_done += 1
		get_tree().change_scene_to_file("res://scenes/minigame_" + str(Global.minigames_done) + ".tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/title_screen.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match Global.lives:
		4:
			life5.hide()
		3:
			life5.hide()
			life4.hide()
		2:
			life5.hide()
			life4.hide()
			life3.hide()
		1:
			life5.hide()
			life4.hide()
			life3.hide()
			life2.hide()
		0:
			life_container.hide()
	timer.text = str(time)
	level.text = "Level" + str(Global.minigames_done)


func Timer(start_time: float):
	time = start_time
	
	while time > 0.0:
		await wait(0.1)
		time -= 0.1
	
	return
	

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
