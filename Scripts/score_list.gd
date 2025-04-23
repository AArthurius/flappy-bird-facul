extends VBoxContainer

# Shadow dos ranks
@onready var rank0: Label = $Score/Rank
@onready var rank1: Label = $Score2/Rank
@onready var rank2: Label = $Score3/Rank
@onready var rank3: Label = $Score4/Rank
@onready var rank4: Label = $Score5/Rank

# Shadow do score
@onready var score0: Label = $Score/Score
@onready var score1: Label = $Score2/Score
@onready var score2: Label = $Score3/Score
@onready var score3: Label = $Score4/Score
@onready var score4: Label = $Score5/Score

# Texto dos ranks
@onready var rankText0: Label = $Score/Rank/Text
@onready var rankText1: Label = $Score2/Rank/Text
@onready var rankText2: Label = $Score3/Rank/Text
@onready var rankText3: Label = $Score4/Rank/Text
@onready var rankText4: Label = $Score5/Rank/Text

# Texto do score
@onready var scoreText0: Label = $Score/Score/Text
@onready var scoreText1: Label = $Score2/Score/Text
@onready var scoreText2: Label = $Score3/Score/Text
@onready var scoreText3: Label = $Score4/Score/Text
@onready var scoreText4: Label = $Score5/Score/Text

func _ready() -> void:
	# Shadow dos ranks
	var rankShadowList = [rank0, rank1, rank2, rank3, rank4]
	# Shadow do score
	var scoreShadowList = [score0, score1, score2, score3, score4]
	# Texto dos ranks
	var rankTextList = [rankText0, rankText1, rankText2, rankText3, rankText4]
	# Texto do score
	var scoreTextList = [scoreText0, scoreText1, scoreText2, scoreText3, scoreText4]
	
	var Highscores = Global.Highscores
	
	# Ordenar as pontuações
	Highscores.sort()
	Highscores.reverse()
	
	# Atualizar as pontuações
	for i in range(5):  # Corrigido para iterar de 0 a 4
		if Highscores[i] == 0 :
			scoreTextList[i].text = ""
			rankTextList[i].text = ""
		else:
			scoreTextList[i].text = str(Highscores[i])
	
	# Sincroniza as sombras com os textos
	for i in range(5):  # Corrigido para iterar de 0 a 4
		rankShadowList[i].text = rankTextList[i].text
		scoreShadowList[i].text = scoreTextList[i].text
