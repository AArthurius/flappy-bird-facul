extends Control

@onready var point_display: Label = $"Point Display"
@onready var jogador: CharacterBody2D = $"../../Jogador"
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var pause_button: TextureButton = $"Pause Container/Pause Button"

const BUTTON_PAUSE = preload("res://sprites/button_pause.png")
const BUTTON_RESUME = preload("res://sprites/button_resume.png")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	point_display.text = str(Global.currentScore)
	if get_tree().paused:
		pause_button.texture_normal = BUTTON_RESUME
	else:
		pause_button.texture_normal = BUTTON_PAUSE

func fade_out_inst():
	animation.play("fade out")

func _on_pause_button_pressed() -> void:
	get_tree().paused = !get_tree().paused
