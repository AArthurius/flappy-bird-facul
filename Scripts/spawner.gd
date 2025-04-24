extends Node2D

@onready var marker_h: Marker2D = $MarkerH
@onready var marker_h_2: Marker2D = $MarkerH2
@onready var marker_v: Marker2D = $MarkerV
@onready var marker_v_2: Marker2D = $MarkerV2

@onready var jogador: CharacterBody2D = $"../Jogador"
@onready var timer: Timer = $Timer

const CANOS = preload("res://Cenas/canos.tscn")

@export var ativo = true

#func _process(delta: float) -> void:
	#if Input.is_action_just_pressed("ui_accept"):
		#spawnPipe()

func start():
	timer.start()
	spawnPipe()

func _on_timer_timeout() -> void:
	if jogador.started == false or jogador.morto:
		return
	spawnPipe()

func spawnPipe():
	if ativo:
		var direção = randi() % 2
		if direção == 0:
			var cano = CANOS.instantiate()
			cano.position.x = marker_h.position.x
			cano.position.y = pos_y_aleatoria(0)
			cano.dir = 0
			add_child(cano)
		else:
			var cano = CANOS.instantiate()
			cano.position.x = pos_y_aleatoria(1)
			cano.position.y = marker_v.position.y
			cano.dir = 1
			add_child(cano)

func pos_y_aleatoria(dir):
	if dir == 0:
		return randi_range(marker_h.position.y, marker_h_2.position.y)
	else:
		return randi_range(marker_v.position.x, marker_v_2.position.x)
