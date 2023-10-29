extends Control


func _process(_delta):
	if GameService.checkWinCondition():
		GameVariables.currentScreen = GameConstants.WIN_VIEW
		print("You win!")


func _input(event):
	if event is InputEventMouseButton:
		if GameVariables.currentScreen == GameConstants.GAME_SCREEN:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				# GameService.parseValidGameInput(event, self)
				pass
		elif GameVariables.currentScreen == GameConstants.WIN_VIEW:
			# only accept button presses from the win overlay
			pass


func _on_back_button_pressed():
	GameVariables.currentScreen = GameConstants.MAIN_MENU
