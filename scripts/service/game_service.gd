extends Node


var boardSize : Vector2i
var cellSize : int
var gridOffset : int
var tempMarkers : Array


var gameCell = preload("res://scenes/game_cell.tscn")


# maybe replace these with a recursive switch statement and move to another class
func prettyPrintArray(array):
	for entry in array:
		print(str(entry))
	print()


func prettyPrintDictionary(dictionary):
	for entry in dictionary:
		print("\"" + str(entry) + "\": " + str(dictionary[entry]))
	print()


func checkWinCondition():
	if (GameVariables.gridData == GameVariables.solutionGrid and
				GameVariables.gameStatus != GameConstants.gameComplete):
		GameVariables.gameStatus = GameConstants.gameComplete
		return true
	return false


func runConfigurationFunctions():
	randomize()
	setVariables()
	initializeSolutionGridArray()
	initializeTempMarkers()
	setStartingNumbers()


func setVariables():
	GridSizeService.getRandomGrid()
	var boardLength = GameConstants.gridSize
	boardSize = Vector2i(boardLength, boardLength) 
	
	GameVariables.cellsInRow = GameVariables.currentBoardSize()
	GameVariables.defaultCells = []
	
	cellSize = MathService.integerDivision(boardLength, GameVariables.cellsInRow)
	gridOffset = 50
	
	GameVariables.numberLists = {}


func isWithinBoard(cell):
	var validX = 0 <= cell.x and cell.x < GameVariables.cellsInRow
	var validY = 0 <= cell.y and cell.y < GameVariables.cellsInRow
	return validX and validY


func addNumberToGridArray(cell):
	if (GameVariables.gridData[cell.y][cell.x] != -1):
		GameVariables.gridData[cell.y][cell.x] = GameVariables.currentNumber


func initializeTempMarkers():
	tempMarkers = []
	tempMarkers.resize(GameVariables.cellsInRow)
	for n in GameVariables.cellsInRow:
		var array = []
		array.resize(GameVariables.cellsInRow)
		array.fill(null)
		tempMarkers[n] = array


func initializeSolutionGridArray():
	var horizontalNumbers = []
	var verticalNumbers = []
	
	horizontalNumbers = generateSolutionGridAndTrackHorizontalNumbers()
	verticalNumbers = trackVerticalNumbers()
	
	GameVariables.numberLists = convertListOfNumbersToMap(horizontalNumbers + verticalNumbers)
	
	print("Solution Grid:")
	prettyPrintArray(GameVariables.solutionGrid)
	print("Numbers:")
	prettyPrintDictionary(GameVariables.numberLists)


func generateSolutionGridAndTrackHorizontalNumbers():
	var currentHorizontalNumber = ""
	var tempHorizontalNumbers = []
	GameVariables.solutionGrid = []
	GameVariables.solutionGrid.resize(GameVariables.cellsInRow)
	for row in GameVariables.gridData.size():
		var tempRow = []
		tempRow.resize(GameVariables.cellsInRow)
		tempRow.fill(-1)
		for column in GameVariables.gridData[row].size():
			if GameVariables.gridData[row][column] == -1:
				if currentHorizontalNumber != "":
					tempHorizontalNumbers += [currentHorizontalNumber]
					currentHorizontalNumber = ""
				continue
			var number = randi() % 10
			currentHorizontalNumber += str(number)
			tempRow[column] = number
		GameVariables.solutionGrid[row] = tempRow
		if currentHorizontalNumber != "":
			tempHorizontalNumbers += [currentHorizontalNumber]
			currentHorizontalNumber = ""
	return tempHorizontalNumbers


func trackVerticalNumbers():
	var currentVerticalNumber = ""
	var tempVerticalNumbers = []
	for column in GameVariables.solutionGrid.size():
		var tempColumn = []
		tempColumn.resize(GameVariables.cellsInRow)
		tempColumn.fill(-1)
		for row in GameVariables.solutionGrid[column].size():
			if GameVariables.solutionGrid[row][column] == -1:
				if currentVerticalNumber != "":
					tempVerticalNumbers += [currentVerticalNumber]
					currentVerticalNumber = ""
				continue
			var number = GameVariables.solutionGrid[row][column]
			currentVerticalNumber += str(number)
		if currentVerticalNumber != "":
			tempVerticalNumbers += [currentVerticalNumber]
			currentVerticalNumber = ""
	return tempVerticalNumbers


func convertListOfNumbersToMap(numbers):
	var tempNumbers = {}
	numbers.sort_custom(func(a, b): 
		var result = false
		result = b.length() > a.length()
		if b.length() == a.length():
			result = int(b) > int(a)
		return result
	)
	
	for number in numbers:
		if !tempNumbers.has(number.length()):
			tempNumbers[number.length()] = []
		# var equation = MathService.getAdditionFormulaForNumber(number)
		tempNumbers[number.length()] += [number]
	
	return tempNumbers


func rotateArray(array):
	var n = []
	for i in array.size():
		var r = []
		r.resize(array.size())
		n.append(r)
	for i in array.size():
		for j in array[i].size():
			n[(array.size()-1)-j][i] = array[i][j]
	return n


func setStartingNumbers():
	var startingHints = 0
	
	if GameVariables.difficulty == GameConstants.EASY:
		startingHints = 3
	elif GameVariables.difficulty == GameConstants.MEDIUM:
		startingHints = 2
	elif GameVariables.difficulty == GameConstants.HARD:
		startingHints = 1
	else: return
	
	var quadrant = randi() % 3
	var upperIndexes = []
	var lowerIndexes = []
	
	for i in range(MathService.integerDivision(GameVariables.cellsInRow, 2)):
		lowerIndexes.append(i)
	for i in range(MathService.integerDivision((GameVariables.cellsInRow + 1), 2), GameVariables.cellsInRow):
		upperIndexes.append(i)
	upperIndexes.reverse()
	
	var yBounds = lowerIndexes
	var horizontalIndex = 0
	var horizontalOffset = 1
	if quadrant >= 2:
		yBounds = upperIndexes
		horizontalIndex = GameVariables.cellsInRow - 1
		horizontalOffset = -1
	
	var xBounds = lowerIndexes
	var verticalIndex = 0
	var verticalOffset = 1
	if quadrant % 2 != 0:
		xBounds = upperIndexes
		verticalIndex = GameVariables.cellsInRow - 1
		verticalOffset = -1
	
	print("Quadrant: " + str(quadrant))
	print("xBounds: " + str(xBounds))
	print("yBounds: " + str(yBounds))

	
	if startingHints >= 1:
		setHorizontalIndex(xBounds, yBounds, upperIndexes, horizontalIndex, horizontalOffset)
	
	if startingHints >= 2:
		setVerticalIndex(xBounds, yBounds, upperIndexes, verticalIndex, verticalOffset)
	
	if startingHints == 3:
		setExtraHint(xBounds, yBounds, lowerIndexes, upperIndexes, horizontalIndex, horizontalOffset)
		pass


func setExtraHint(xBounds, yBounds, lowerIndexes, upperIndexes, index, horizontalOffset):
	if yBounds == upperIndexes:
		yBounds = lowerIndexes
	else:
		yBounds = upperIndexes
	if xBounds == upperIndexes:
		xBounds = lowerIndexes
	else:
		xBounds = upperIndexes
	setHorizontalIndex(xBounds, yBounds, upperIndexes, index, horizontalOffset)


func setHorizontalIndex(xBounds, yBounds, upperIndexes, index, horizontalOffset):
	var horizontalIndex = getHorizontalIndex(xBounds, yBounds, index) + horizontalOffset
	var horizontalNumberString = ""
	var cells = range(GameVariables.cellsInRow)
	if (xBounds == upperIndexes):
		cells.reverse()
	var horizontalRow = GameVariables.solutionGrid[horizontalIndex]
	var started = false
	for i in cells:
		var digit = horizontalRow[i]
		if digit == -1:
			if started:
				break
			else:
				continue
		started = true
		horizontalNumberString += str(digit)
		var cell = Vector2i(i, horizontalIndex)
		GameVariables.gridData[cell.y][cell.x] = digit
	GameVariables.defaultNumbers.append(horizontalNumberString)
	GameVariables.crossedOutNumbers.append(horizontalNumberString)


func setVerticalIndex(xBounds, yBounds, upperIndexes, index, verticalOffset):
	var verticalIndex = getHorizontalIndex(yBounds, xBounds, index) + verticalOffset
	var verticalNumbersString = ""
	var cells = range(GameVariables.cellsInRow)
	var started = false
	if (yBounds == upperIndexes):
		print("reversing via Y")
		cells.reverse()
	for i in cells:
		var row = GameVariables.solutionGrid[i]
		if row[verticalIndex] == -1:
			if started:
				break
			else:
				continue
		started = true
		var digit = row[verticalIndex]
		verticalNumbersString += str(digit)
		var cell = Vector2i(verticalIndex, i)
		GameVariables.gridData[cell.y][cell.x] = digit
	GameVariables.defaultNumbers.append(verticalNumbersString)
	GameVariables.crossedOutNumbers.append(verticalNumbersString)


func getHorizontalIndex(xBounds, yBounds, index):
	var length = -1
	for rowIndex in yBounds:
		var whiteBlocks = 0
		for columnIndex in xBounds:
			if GameVariables.gridData[rowIndex][columnIndex] == -1:
				break
			whiteBlocks += 1
		if length == -1 or whiteBlocks == length:
			length = whiteBlocks
			index = rowIndex
		elif whiteBlocks != length:
			break
	return index


func addDefaultNumberToGrid(index):
	var numbersString = ""
	for i in GameVariables.solutionGrid.size():
		var row = GameVariables.solutionGrid[i]
		if row[index] == -1: break
		var digit = row[index]
		numbersString += str(digit)
		var cell = Vector2i(index, i)
		GameVariables.gridData[cell.y][cell.x] = digit
	GameVariables.defaultNumbers.append(numbersString)
	GameVariables.crossedOutNumbers.append(numbersString)


func onBackButtonPressed():
	GameVariables.currentScreen = GameConstants.MAIN_MENU


func getScaleForGrid():
	var width = GameVariables.cellsInRow * GameConstants.tileSize
	return GameConstants.gridSize / (width as float)
