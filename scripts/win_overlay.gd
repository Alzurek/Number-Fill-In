extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




func _on_main_menu_button_pressed():
	# also delete old game instance (must make it dynamically create on start game first)
	GameVariables.currentScreen = GameConstants.MAIN_MENU
