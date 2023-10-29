extends Control


func _process(_delta):
	var difficultyMessage = ''
	var sizeMessage = ''
	var numberOfHints = 0
	var plural = 's'
	
	if GameVariables.difficulty == GameConstants.EASY:
		difficultyMessage = 'easy'
		numberOfHints = 3
	elif GameVariables.difficulty == GameConstants.MEDIUM:
		difficultyMessage = 'medium'
		numberOfHints = 2
	elif GameVariables.difficulty == GameConstants.HARD:
		difficultyMessage = 'hard'
		numberOfHints = 1
		plural = ''
	elif GameVariables.difficulty == GameConstants.EXPERT:
		difficultyMessage = 'expert'
		numberOfHints = 'no'
	
	if GameVariables.boardCells == GameConstants.THIRTEEN:
		sizeMessage = '13'
	if GameVariables.boardCells == GameConstants.FIFTEEN:
		sizeMessage = '15'
	if GameVariables.boardCells == GameConstants.NINETEEN:
		sizeMessage = '19'
	if GameVariables.boardCells == GameConstants.TWENTY_ONE:
		sizeMessage = '21'
		
	var difficultyInfo = get_node('Selection Info/Difficulty Info')
	var text = 'Games will be generated with a grid of size ' + sizeMessage
	text +=' on the ' + difficultyMessage + ' difficulty, giving the player '
	
	text += str(numberOfHints) + ' hint' + plural
	difficultyInfo.text = text


func _on_easy_pressed():
	GameVariables.difficulty = GameConstants.EASY


func _on_medium_pressed():
	GameVariables.difficulty = GameConstants.MEDIUM


func _on_hard_pressed():
	GameVariables.difficulty = GameConstants.HARD


func _on_expert_pressed():
	GameVariables.difficulty = GameConstants.EXPERT


func _on_x_13_pressed():
	processGridSizeButton(GameConstants.THIRTEEN)


func _on_x_15_pressed():
	processGridSizeButton(GameConstants.FIFTEEN)


func _on_x_19_pressed():
	processGridSizeButton(GameConstants.NINETEEN)


func _on_x_21_pressed():
	processGridSizeButton(GameConstants.TWENTY_ONE)


func processGridSizeButton(_size):
	GameVariables.boardCells = _size
	GameRepo.initializeGrid()

func _on_back_button_pressed():
	GameVariables.currentScreen = GameConstants.MAIN_MENU
