extends Node


func getRandomGrid():
	GameRepo.setNewGridOfSize(GameVariables.currentBoardSize())
	print("New Grid:\n" + str(GameService.prettyPrintArray(GameVariables.gridData)))
