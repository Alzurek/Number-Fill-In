extends Node


func moveScene(scene, newPosition):
	var duration = 0.5
	
	var tween = create_tween()
	tween.tween_property(scene, "position", newPosition, duration)


# Does not actually return a boolean, it returns a value if true, and null if false
func canSceneMove(inViewport, screens, inWindowPosition, outofWindowPosition):
	var newPosition = null
	if !inViewport:
		if 	screens.has(GameVariables.currentScreen):
			# move into viewport, it is not in viewport but should be
			newPosition = inWindowPosition
	else:
		if !screens.has(GameVariables.currentScreen):
			# move out of viewport, it is in viewport but should not be
			newPosition = outofWindowPosition
	return newPosition
