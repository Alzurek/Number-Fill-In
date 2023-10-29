extends Control


var duration = 0.5
var sizeScale = 0.75
enum {ON_SCREEN, OFF_SCREEN, BACKGROUND}
var currentState = ON_SCREEN


func _process(_delta):
	var startButton = get_node('Main Menu/Start')
	if (startButton.disabled and GameVariables.currentScreen == GameConstants.MAIN_MENU):
		toggleButtons()
	startButton = get_node('Main Menu/Start')
	if (GameVariables.currentScreen == GameConstants.MAIN_MENU):
		if currentState == BACKGROUND or currentState == OFF_SCREEN:
			var tween = create_tween()
			tween.parallel().tween_property(self, 'position', Vector2(0, 0), duration)
			if currentState == BACKGROUND:
				tween.parallel().tween_property(self, 'scale', Vector2(1, 1), duration)
		currentState = ON_SCREEN


func toggleButtons():
	var mainMenuButtons = get_node('Main Menu')
	for button in mainMenuButtons.get_children():
		button.disabled = !button.disabled


func _on_start_pressed():
	var tween = create_tween()
	var newPosition = Vector2(-500, 0)
	GameVariables.currentScreen = GameConstants.GAME_SCREEN
	tween.tween_property(self, "position", newPosition, duration)
	currentState = OFF_SCREEN


func _on_difficulty_pressed():
	unfocusMainMenu(GameConstants.DIFFICULTY_MENU)


func _on_settings_pressed():
	unfocusMainMenu(GameConstants.SETTINGS_MENU)


func unfocusMainMenu(screen):
	var subMenuPosition = Vector2(-50, 0)
	var tween = create_tween()
	GameVariables.currentScreen = screen
	tween.parallel().tween_property(self, "position", subMenuPosition, duration)
	tween.parallel().tween_property(self, "scale", Vector2(sizeScale, sizeScale), duration)
	toggleButtons()
	currentState = BACKGROUND


func _on_quit_pressed():
	get_tree().quit()
