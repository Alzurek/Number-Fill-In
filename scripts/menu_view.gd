extends Node2D

var inViewport = true


func _process(_delta):
	var screens = [
		GameConstants.SETTINGS_MENU,
		GameConstants.DIFFICULTY_MENU
	]
	var newPosition = ScenePhysics.canSceneMove(inViewport, GameConstants.MAIN_MENU, Vector2(0, 0), Vector2(-500, 0))
	
	if newPosition != null:
		if GameVariables.currentScreen in screens:
			newPosition = Vector2i(0,0)
		ScenePhysics.moveScene(self, newPosition)
		inViewport = !inViewport
