extends Control

@onready var start: TextureButton = $HBoxContainer/Start
@onready var high_scores: TextureButton = $HBoxContainer/HighScores

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_start_button_up() -> void:
	Global.goto_scene("res://jogo.tscn")

func _on_high_scores_button_up() -> void:
	pass # Replace with function body.
