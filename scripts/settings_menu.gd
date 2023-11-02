extends Control


func _ready():
	updateColorPickerButton("Background Color", UserVariables.backgroundThemeColor)
	updateColorPickerButton("Background Accent Color", UserVariables.backgroundAccentColor)
	updateColorPickerButton("Grid Primary Color", UserVariables.gridPrimaryColor)
	updateColorPickerButton("Grid Secondary Color", UserVariables.gridSecondaryColor)
	updateColorPickerButton("Grid Accent Color", UserVariables.gridAccentColor)
	
	var autoSecondaryButton = get_node("ScrollContainer/VBoxContainer/Color Section/Color Options/Grid Secondary Color/HSplitContainer/HSplitContainer/Auto Grid Secondary") as Button
	if autoSecondaryButton.button_pressed:
		var gridSecoondaryColorButton = get_node('ScrollContainer/VBoxContainer/Color Section/Color Options/Grid Secondary Color/Control/Color Display') as Button
		gridSecoondaryColorButton.disabled = true
		var resetSecondaryButton = get_node("ScrollContainer/VBoxContainer/Color Section/Color Options/Grid Secondary Color/HSplitContainer/Reset Grid Secondary") as Button
		resetSecondaryButton.disabled = true


func _on_back_button_pressed():
	GameVariables.currentScreen = GameConstants.MAIN_MENU


func updateColorPickerButton(container : String, color : Color):
	var colorPicker = get_node("ScrollContainer/VBoxContainer/Color Section/Color Options/" + container + "/Control/Color Display") as Button
	
	var buttonTheme = colorPicker.get_theme_stylebox("normal") as StyleBox
	buttonTheme.bg_color = color
	colorPicker.remove_theme_stylebox_override("normal")
	colorPicker.add_theme_stylebox_override("normal", buttonTheme)
