extends CharacterBody2D
class_name Player

@export_category("Stats")
@export var speed: int = 400

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var animation_playback: AnimationNodeStateMachinePlayback = $AnimationTree["parameters/playback"]

const IS_MOVING = "parameters/conditions/is_moving"

var last_direction := Vector2.DOWN

func _ready() -> void:
	animation_tree.set_active(true)
	animation_playback.travel("idle")

func _physics_process(_delta: float) -> void:
	var input_dir = Input.get_vector("left", "right", "up", "down")
	
	if input_dir.length_squared() > 0.01:
		velocity = input_dir.normalized() * speed
		last_direction = input_dir.normalized()
		
		if Input.is_action_pressed("left"):
			$Sprite2D.flip_h = true
		else:
			$Sprite2D.flip_h = false

		animation_tree.set("parameters/run/blend_position", last_direction)
		animation_tree.set(IS_MOVING, true)
		animation_playback.travel("run")
	else:
		velocity = Vector2.ZERO
		animation_tree.set(IS_MOVING, false)
		animation_tree.set("parameters/idle/blend_position", last_direction)
		animation_playback.travel("idle")
		
	move_and_slide()
