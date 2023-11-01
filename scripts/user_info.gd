extends Control


func _process(_delta):
	if UserVariables.currentUser != null:
		get_node('Username').text = UserVariables.currentUser.username

	if GameVariables.currentScreen != GameConstants.LOGIN_SCREEN and not is_visible():
		set_visible(true)
	elif GameVariables.currentScreen == GameConstants.LOGIN_SCREEN:
		set_visible(false)
