extends TileMap


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

