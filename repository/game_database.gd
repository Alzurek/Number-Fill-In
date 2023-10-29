extends Node

var data = []
var currentSize : int

var dataFilePath = "res://assets/grids/"

func loadJsonFile(filePath):
	if FileAccess.file_exists(filePath):
		var dataFile = FileAccess.open(filePath, FileAccess.READ)
		var parsedResult = JSON.parse_string(dataFile.get_as_text())
		
		if parsedResult is Array:
			return parsedResult
		else:
			print("Error reading file")
	else:
		print("File does not exist")

func initializeGrid():
	var size = GameVariables.currentBoardSize()
	if currentSize == null or currentSize != size:
		data = loadJsonFile(dataFilePath + "size" + str(size) + ".json")
		currentSize = size
	

func setNewGridOfSize(size : int):
	initializeGrid()
	var randomIndex = randi() % data.size()
	GameVariables.gridData = data[randomIndex]
