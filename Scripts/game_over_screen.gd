extends Control

@onready var scoreShadow: Label = $"Game Over tems/Score Panel/Score"
@onready var scoreText: Label = $"Game Over tems/Score Panel/Score/Text"
@onready var bestShadow: Label = $"Game Over tems/Score Panel/Best"
@onready var bestText: Label = $"Game Over tems/Score Panel/Best/Text"
@onready var animation: AnimationPlayer = $"../AnimationPlayer"

@onready var new_best_icon: TextureRect = $"Game Over tems/Score Panel/New best icon"
@onready var medal_icon: TextureRect = $"Game Over tems/Score Panel/Medal Icon"

const MEDAL_BRONZE = preload("res://sprites/UI/medal_bronze.png")
const MEDAL_SILVER = preload("res://sprites/UI/medal_silver.png")
const MEDAL_GOLD = preload("res://sprites/UI/medal_gold.png")
const MEDAL_PLATINUM = preload("res://sprites/UI/medal_platinum.png")
@onready var spark_timer: Timer = $"Game Over tems/Score Panel/Medal Icon/Spark timer"


var sparked = 0
var previousHighscore = 0
var medal = false
var spark = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	previousHighscore = Global.HighestScore
	new_best_icon.hide()
	medal_icon.hide()
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	scoreText.text = str(Global.currentScore)
	bestText.text = str(Global.HighestScore)
	
	if Global.currentScore > 10:
		medal = true
	
	match Global.currentScore:
		10:
			medal_icon.texture = MEDAL_BRONZE
		20:
			medal_icon.texture = MEDAL_SILVER
		30:
			medal_icon.texture = MEDAL_GOLD
		40:
			medal_icon.texture = MEDAL_PLATINUM
	
	
	
	
	
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
	if anim_name == "Game Over":
		if Global.currentScore > previousHighscore:
			new_best_icon.show()
		if medal:
			medal_icon.show()
			animation.play("Fade Medal")
	if anim_name == "Fade Medal":
		spark = true


func _on_spark_timer_timeout() -> void:
	if spark:
		var sparking = randi() % medal_icon.get_children().size()
		if sparking != sparked:
			medal_icon.get_child(sparking).play("default")
			sparked = sparking
		else:
			_on_spark_timer_timeout()
