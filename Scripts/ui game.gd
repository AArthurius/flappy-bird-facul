extends Control

@onready var point_display: Label = $"Point Display"
@onready var jogador: CharacterBody2D = $"../../Jogador"
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var pause_button: TextureButton = $"Pause Container/Pause Button"
@onready var game_over_screen: Control = $"Game Over Screen"

const BUTTON_PAUSE = preload("res://sprites/UI/button_pause.png")
const BUTTON_RESUME = preload("res://sprites/UI/button_resume.png")


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

func flash():
	$Flash.show()
	animation.play("flash")
	pause_button.visible = false

func gameOver():
	$Flash.show()
	pause_button.visible = false
	animation.play("Game Over")
	game_over_screen.show()
	


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "flash":
		gameOver()
