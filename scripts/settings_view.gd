extends Node2D


var inViewport = false


func _process(_delta):
	var newPosition = ScenePhysics.canSceneMove(inViewport, GameConstants.SETTINGS_MENU, Vector2(0, 0), Vector2(900, 0))
	if newPosition != null:
		ScenePhysics.moveScene(self, newPosition)
		inViewport = !inViewport

