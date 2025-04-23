extends Node2D

@onready var marker_2d: Marker2D = $Marker2D
@onready var marker_2d_2: Marker2D = $Marker2D2
@onready var jogador: CharacterBody2D = $"../Jogador"

const CANOS = preload("res://Cenas/canos.tscn")
#func _process(delta: float) -> void:
	#if Input.is_action_just_pressed("ui_accept"):
		#spawnPipe()

func _ready() -> void:
	spawnPipe()

func _on_timer_timeout() -> void:
	if jogador.started == false or jogador.morto:
		return
	spawnPipe()

func spawnPipe():
	var cano = CANOS.instantiate()
	cano.position.x = marker_2d.position.x
	cano.position.y = pos_y_aleatoria()
	add_child(cano)

func pos_y_aleatoria():
	return randi_range(marker_2d.position.y, marker_2d_2.position.y)
