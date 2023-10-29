extends Node


var currentNumber = 0
var numberLists : Dictionary
var crossedOutNumbers : Array
var defaultNumbers : Array
var solutionGrid : Array
var defaultCells : Array
var gridData : Array
var currentScreen = GameConstants.MAIN_MENU
var finishedGroups = []
var cellsInRow : int


var numberListUpdated = false


var gameStatus = GameConstants.gameStarted


var difficulty = GameConstants.MEDIUM


var boardCells = GameConstants.THIRTEEN


func currentBoardSize():
	if boardCells == GameConstants.THIRTEEN:
		return 13
	elif boardCells == GameConstants.FIFTEEN:
		return 15
	elif boardCells == GameConstants.NINETEEN:
		return 19
	elif boardCells == GameConstants.TWENTY_ONE:
		return 21
	else: return -1
