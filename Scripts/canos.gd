extends CharacterBody2D

@export var velocidade = 100
@onready var cano_cima: Area2D = $"Cano Cima"
@onready var cano_baixo: Area2D = $"Cano Baixo"
@onready var jogador: CharacterBody2D = $"../../Jogador"

var dir = 0
var range = 5

func _ready() -> void:
	if jogador.morto:
		return
	var pos = randi_range(-range, range)
	cano_cima.position.y = cano_cima.position.y - pos
	cano_baixo.position.y = cano_baixo.position.y + pos
	if dir != 0:
		rotation = deg_to_rad(90)
		velocity.y = velocidade
	else:
		rotation = deg_to_rad(0)
		velocity.x = -velocidade

func _physics_process(delta: float) -> void:
	if jogador.morto:
		return
	move_and_slide()

func _on_despawn_timeout() -> void:
	if jogador.morto:
		return
	queue_free()

func _on_points_area_entered(area: Area2D) -> void:  
	if area.is_in_group("player"):
		Global.addPoint()
