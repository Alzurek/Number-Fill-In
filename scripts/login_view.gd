extends Node2D


var loginScene = preload("res://scenes/login_screen.tscn")
var inViewport = false
var currentScene = null
var timeSinceMove = 0
var closedLoginTimer = false
var loginInstances = 0


func _process(_delta):
	if closedLoginTimer:
		timeSinceMove += _delta
	if timeSinceMove >= 0.5:
		timeSinceMove = 0
		closedLoginTimer = false
		remove_child(currentScene)
		currentScene = null

	var newPosition = ScenePhysics.canSceneMove(inViewport, GameConstants.LOGIN_SCREEN, Vector2(0, 0), Vector2(0, 650))
	if newPosition != null:
		ScenePhysics.moveScene(self, newPosition)
		if loginInstances == 0:
			currentScene = loginScene.instantiate()
			add_child(currentScene)
			loginInstances = 1
		else:
			closedLoginTimer = true
			loginInstances = 0
		inViewport = !inViewport
