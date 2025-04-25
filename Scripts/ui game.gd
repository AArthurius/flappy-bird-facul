extends Control

@onready var point_display: Label = $"Point Display"
@onready var jogador: CharacterBody2D = $"../../Jogador"
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var pause_button: TextureButton = $"Pause Container/Pause Button"
@onready var game_over_screen: Control = $"Game Over Screen"
@onready var spawner: Node2D = $"../../Spawner"
@onready var animation2: AnimationPlayer = $AnimationPlayer2

const BUTTON_PAUSE = preload("res://sprites/UI/button_pause.png")
const BUTTON_RESUME = preload("res://sprites/UI/button_resume.png")

func _ready():
	$fade.show()
	animation.play("game fade in")
	Global.currentScore = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	point_display.text = str(Global.currentScore)
	if get_tree().paused:
		pause_button.texture_normal = BUTTON_RESUME
	else:
		pause_button.texture_normal = BUTTON_PAUSE

func fade_out_inst():
	#spawns first pipe
	spawner.start()
	#fades out instructons
	animation2.play("fade out")

func _on_pause_button_pressed() -> void:
	print("pause")
	get_tree().paused = !get_tree().paused

func flash():
	$Flash.show()
	animation.play("flash")
	pause_button.visible = false

func gameOver():
	$fade.hide()
	$Flash.show()
	pause_button.visible = false
	animation.play("Game Over")
	game_over_screen.show()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	match anim_name:
		"flash":
			$Flash.queue_free()
			gameOver()
		"instructions fade out":
			if jogador.started:
				$"Center Instructions".queue_free()
			else:
				animation.play("instructions fade in")
		"instructions fade in":
			animation.play("instructions fade out")
		"game fade in":
			$fade.hide()
			
