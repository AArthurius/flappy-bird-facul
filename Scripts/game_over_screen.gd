extends Control

@onready var scoreShadow: Label = $"Game Over tems/Score Panel/Score"
@onready var scoreText: Label = $"Game Over tems/Score Panel/Score/Text"
@onready var bestShadow: Label = $"Game Over tems/Score Panel/Best"
@onready var bestText: Label = $"Game Over tems/Score Panel/Best/Text"
@onready var animation: AnimationPlayer = $"../AnimationPlayer"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	scoreText.text = str(Global.currentScore)
	bestText.text = str(Global.HighestScore)
	
	#sincronizar textos
	scoreShadow.text = scoreText.text
	bestShadow.text = bestText.text

func _on_restart_button_button_up() -> void:
	Global.currentScore = 0
	Global.get_tree().reload_current_scene()

func _on_menu_button_button_up() -> void:
	$"../fade".show()
	animation.play("game fade out")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "game fade out":
		Global.currentScore = 0
		Global.goto_scene("res://Cenas/menu.tscn")
