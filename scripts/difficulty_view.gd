extends Node2D

var inViewport = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var newPosition = ScenePhysics.canSceneMove(inViewport, GameConstants.DIFFICULTY_MENU, Vector2(0, 0), Vector2(0, -700))
	if newPosition != null:
		ScenePhysics.moveScene(self, newPosition)
		inViewport = !inViewport
