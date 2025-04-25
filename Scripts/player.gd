extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $Sprite
@onready var ui: Control = $"../CanvasLayer/UI"

const GRAVIDADE = 1000
const VELOCIDADE_ROTAÇÃO = 0.5
const ACC = 100
const SPEED = 100
const MAXSPEED = 200


var cheating = false
var cheatDir = Vector2(0, 0)

var dir = 0.0
var started = false
var morto = false

func _process(delta: float) -> void:
	if morto:
		$CollisionShape2D.disabled = true
		$hitbox.monitoring = false
	if !started:
		sprite.play("voar")
		if Input.is_action_just_pressed("espaço") and not morto:    
			voar()
			started = true
			ui.fade_out_inst()
		return
	

	
	dir = Input.get_axis("A", "D")
	
	
	
	if velocity.y < 0:
		sprite.rotation += deg_to_rad(-VELOCIDADE_ROTAÇÃO)
	else:
		sprite.rotation += deg_to_rad(VELOCIDADE_ROTAÇÃO)
	
	
	
	#cheats
	if Input.is_action_just_pressed("Cheat"):
		cheating = !cheating
	cheatDir = Input.get_vector("A","D","W","S")
	
	
	if cheating:
		if Input.is_action_just_pressed("Up"):
			Global.currentScore += 1
		if Input.is_action_just_pressed("Down"):
			Global.currentScore -= 1
		
		sprite.rotation = deg_to_rad(0)
		$CollisionShape2D.disabled = true
		$hitbox.monitoring = false
	else:
		$CollisionShape2D.disabled = false
		$hitbox.monitoring = true
	
	
	sprite.rotation = clamp(sprite.rotation, deg_to_rad(-45), deg_to_rad(90))

func _physics_process(delta: float) -> void:
	if !started:
		return
	
	if Input.is_action_just_pressed("espaço") and not morto and not cheating:    
		voar()
	elif not cheating:
		velocity.y = velocity.y + GRAVIDADE * delta
	
	if not cheating:
		if velocity.x > 0:
			velocity.x = velocity.x - ACC * delta
		elif velocity.x < 0:
			velocity.x = velocity.x + ACC * delta
	else:
		velocity = cheatDir * MAXSPEED
	
	
	velocity.x = clamp(velocity.x, -MAXSPEED, MAXSPEED)
	velocity.y = clamp(velocity.y, -200, 200)
	move_and_slide()

func voar():
	velocity.y = -300
	velocity.x = dir * SPEED
	sprite.rotation = deg_to_rad(0)
	sprite.play("voar")

func _on_area_2d_area_entered(area: Area2D) -> void:
	if !area.is_in_group("safe") and not morto:
		morto = true
		if velocity.y < 0:
			velocity.y = 0
		Global.gameOver()
		ui.flash() # flash causa o game over
