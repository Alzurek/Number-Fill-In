extends TileMap


var verticalResults : Dictionary
var horizontalResults : Dictionary


func _ready():
	GameService.runConfigurationFunctions()
	initializeGameGrid()


func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if GameVariables.currentScreen == GameConstants.GAME_SCREEN:
			var tileCell = local_to_map(to_local(get_global_mouse_position()))
			print(str(tileCell))
			if not GameService.isWithinBoard(tileCell): return
			addDigitToBoard(tileCell)
			checkForCompletedNumbers(tileCell)


func initializeGameGrid():
	var tileMapScale = GameService.getScaleForGrid()
	set_scale(Vector2(tileMapScale, tileMapScale))
	
	var rowIndex = 0
	for row in GameVariables.gridData:
		var columnIndex = 0
		for cell in row:
			var coordinate = Vector2i(columnIndex, rowIndex)
			var number = GameVariables.gridData[rowIndex][columnIndex]
			if number == null:
				number = SceneConstants.gridCellId
			elif number == -1:
				number = SceneConstants.gridWallId
				GameVariables.defaultCells.append(coordinate)
			else:
				number += 10
				GameVariables.defaultCells.append(coordinate)
			
			set_cell(0, coordinate, number, Vector2i(0, 0), 0)
			columnIndex += 1
		rowIndex += 1
	print(str(GameVariables.defaultCells))


func addDigitToBoard(cell):
	if GameVariables.defaultCells.has(cell): return
	erase_cell(0, cell)
	set_cell(0, cell, GameVariables.currentNumber, Vector2i(0, 0), 0)

func checkForCompletedNumbers(tileCell):
	# we want to increment in both directions (+/-) for both x/y
	if await doVerticalChecks(tileCell):
		# determine number that was built vertically
		pass
	if await doHorizontalChecks(tileCell):
		# determine number that was built horizontally
		pass


func doVerticalChecks(cell):
	var threadPositive = Thread.new()
	var threadNegative = Thread.new()
	
	threadPositive.start(doVerticalIncrement.bind(cell,  1))
	threadNegative.start(doVerticalIncrement.bind(cell, -1))
	
	var positiveResult = threadPositive.wait_to_finish()
	var negativeResult = threadNegative.wait_to_finish()
	
	return positiveResult and negativeResult


func doHorizontalChecks(cell):
	var threadPositive = Thread.new()
	var threadNegative = Thread.new()
	
	threadPositive.start(doHorizontalIncrement.bind(cell,  1))
	threadNegative.start(doHorizontalIncrement.bind(cell, -1))
	
	var positiveResult = await threadPositive.wait_to_finish()
	var negativeResult = await threadNegative.wait_to_finish()
	
	return positiveResult and negativeResult


func doVerticalIncrement(cell, incrementDirection : int):
	var i = cell.x + incrementDirection
	var lastBlock
	while i >= 0 and i <= GameVariables.gridData.size():
		lastBlock = GameVariables.gridData[i][cell.y]
		if lastBlock == null or lastBlock == -1:
			break;
		i += incrementDirection
	if incrementDirection in verticalResults:
		verticalResults[incrementDirection].append(lastBlock)
	else:
		verticalResults[incrementDirection] = [lastBlock]
	print("Vertical | " + str(incrementDirection) + " | " + lastBlock)
	if lastBlock == null: return null
	if lastBlock == -1: return i - 1
	return i


func doHorizontalIncrement(cell, incrementDirection : int):
	var i = cell.y + incrementDirection
	var lastBlock
	while i >= 0 and i <= GameVariables.gridData.size():
		lastBlock = GameVariables.gridData[cell.x][i]
		if lastBlock == null or lastBlock == -1:
			break;
		i += incrementDirection
	if incrementDirection in horizontalResults:
		horizontalResults[incrementDirection].append(lastBlock)
	else:
		horizontalResults[incrementDirection] = [lastBlock]
	print("Horizontal | " + str(incrementDirection) + " | " + lastBlock)
	if lastBlock == null: return null
	if lastBlock == -1: return i - 1
	return i
