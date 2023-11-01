extends Node2D


var gameScene = preload("res://scenes/game_scene.tscn")
var gameInstances = 0
var timeSinceMove = 0
var closedGameTimer = false
var inViewport = false
var currentScene = null


func _process(_delta):
	if closedGameTimer:
		timeSinceMove += _delta
	if timeSinceMove >= 0.5:
		timeSinceMove = 0
		closedGameTimer = false
		remove_child(currentScene)
		currentScene = null
	# TODO Might need to redo Win View movement
	# var screens = [GameConstants.GAME_SCREEN, GameConstants.WIN_VIEW]
	
	var newPosition = ScenePhysics.canSceneMove(inViewport, GameConstants.GAME_SCREEN, Vector2(0, 0), Vector2(0, 650))
	if newPosition != null:
		ScenePhysics.moveScene(self, newPosition)
		if gameInstances == 0:
			currentScene = gameScene.instantiate()
			add_child(currentScene)
			gameInstances = 1
		else:
			closedGameTimer = true
			gameInstances = 0
		inViewport = !inViewport
