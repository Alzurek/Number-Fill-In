extends Node


func _ready():
	MainService.updateAllColors()
	GameVariables.currentScreen = GameConstants.LOGIN_SCREEN
