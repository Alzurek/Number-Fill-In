extends Node2D

var inViewport = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var screens = [
		GameConstants.SETTINGS_MENU,
		GameConstants.MAIN_MENU,
		GameConstants.DIFFICULTY_MENU
	]
	var newPosition = ScenePhysics.canSceneMove(inViewport, screens, Vector2(0, 0), Vector2(0, 0))
	if newPosition != null:
		ScenePhysics.moveScene(self, newPosition)
		inViewport = !inViewport
