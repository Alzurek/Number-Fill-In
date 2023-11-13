extends Node


func _ready():
	FirebaseService.setSignals()
	MainService.updateAllColors()
	if not Firebase.Auth.load_auth():
		GameVariables.currentScreen = GameConstants.LOGIN_SCREEN
	else:
		FirebaseService.updateCurrentUser(get_node('User Info/Username'))
