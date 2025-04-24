extends Control

@onready var start: TextureButton = $HBoxContainer/Start
@onready var high_scores: TextureButton = $HBoxContainer/HighScores

const JOGO = "res://Cenas/jogo.tscn"

func _ready() -> void:
	$Highscores.hide()

func _on_start_button_up() -> void:
	Global.goto_scene(JOGO)

func _on_high_scores_button_up() -> void:
	$Highscores.visible = !$Highscores.visible
