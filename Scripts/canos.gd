extends CharacterBody2D

@export var velocidade = 100
@onready var cano_cima: Area2D = $"Cano Cima"
@onready var cano_baixo: Area2D = $"Cano Baixo"
@onready var jogador: CharacterBody2D = $"../../Jogador"

func _ready() -> void:
	if jogador.morto:
		return
	velocity.x = -velocidade
	var range = 5
	var pos = randi_range(-range, range)
	cano_cima.position.y = cano_cima.position.y - pos
	cano_baixo.position.y = cano_baixo.position.y + pos

func _physics_process(delta: float) -> void:
	if jogador.morto:
		return
	move_and_slide()

func _on_despawn_timeout() -> void:
	if jogador.morto:
		return
	queue_free()

func _on_points_area_entered(area: Area2D) -> void:  
	Global.addPoint()
