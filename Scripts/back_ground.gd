extends Node2D

@onready var parallax_2d: Parallax2D = $Parallax2D
@onready var parallax_2d_2: Parallax2D = $Parallax2D2
@onready var parallax_2d_3: Parallax2D = $Parallax2D3
@onready var parallax_2d_4: Parallax2D = $Parallax2D4
@onready var jogador: CharacterBody2D = $"../Jogador"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if jogador.morto:
		parallax_2d.autoscroll.x = 0
		parallax_2d_2.autoscroll.x = 0
		parallax_2d_3.autoscroll.x = 0
		parallax_2d_4.autoscroll.x = 0
