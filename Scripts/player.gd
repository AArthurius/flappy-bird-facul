extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var ui: Control = $"../CanvasLayer/UI"

const GRAVIDADE = 1000
const VELOCIDADE_ROTAÇÃO = 0.5

var started = false
var morto = false

func _process(delta: float) -> void:
	if !started:
		if Input.is_action_just_pressed("espaço") and not morto:    
			voar()
			started = true
			ui.fade_out_inst()
		return
	
	if velocity.y < 0:
		sprite.rotation += deg_to_rad(-VELOCIDADE_ROTAÇÃO)
	else:
		sprite.rotation += deg_to_rad(VELOCIDADE_ROTAÇÃO)
	
	sprite.rotation = clamp(sprite.rotation, deg_to_rad(-45), deg_to_rad(90))

func _physics_process(delta: float) -> void:
	if !started:
		return
	
	if Input.is_action_just_pressed("espaço") and not morto:    
		voar()
	else:
		velocity.y = velocity.y + GRAVIDADE * delta
	
	velocity.y = clamp(velocity.y, -200, 200)
	move_and_slide()

func voar():
	velocity.y = -200
	sprite.rotation = deg_to_rad(0)
	sprite.play("voar")

func _on_area_2d_area_entered(area: Area2D) -> void:
	if !area.is_in_group("safe") and not morto:
		morto = true
		if velocity.y < 0:
			velocity.y = 0
		Global.gameOver()
		ui.flash() # flash causa o game over
