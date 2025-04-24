extends Control

@onready var start: TextureButton = $HBoxContainer/Start
@onready var high_scores: TextureButton = $HBoxContainer/HighScores
@onready var animation: AnimationPlayer = $AnimationPlayer

const JOGO = "res://Cenas/jogo.tscn"

func _ready() -> void:
	$fade.show()
	animation.play("menu fade in")
	$Highscores.position.x = 147

func _on_start_button_up() -> void:
	$fade.show()
	animation.play("menu fade out")
	

func _on_high_scores_button_up() -> void:
	if $Highscores.position.x != 0 and not animation.is_playing():
		animation.play("scores enter")
	elif $Highscores.position.x == 0 and not animation.is_playing():
		animation.play("scores leave")



func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "menu fade in":
		$fade.hide()
	if anim_name == "menu fade out":
		Global.goto_scene(JOGO)
