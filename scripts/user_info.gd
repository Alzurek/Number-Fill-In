extends Control


enum {SMALL, NORMAL}

var currentSize = NORMAL

func _process(_delta):
	if UserVariables.currentUser != null:
		get_node('Username').text = UserVariables.currentUser.username

	if GameVariables.currentScreen != GameConstants.LOGIN_SCREEN and not is_visible():
		set_visible(true)
	elif GameVariables.currentScreen == GameConstants.LOGIN_SCREEN:
		set_visible(false)
	
	if GameVariables.currentScreen == GameConstants.GAME_SCREEN and currentSize == NORMAL:
		var tween = create_tween()
		tween.tween_property(self, 'scale', Vector2(1, 1), 0.5)
		currentSize = SMALL
	elif GameVariables.currentScreen != GameConstants.GAME_SCREEN and currentSize == SMALL:
		var tween = create_tween()
		tween.tween_property(self, 'scale', Vector2(1.5, 1.5), 0.5)
		currentSize = NORMAL
