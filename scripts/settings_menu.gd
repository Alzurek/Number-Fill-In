extends Control


func _ready():
	var backgroundColorPicker = get_node("ScrollContainer/VBoxContainer/Color Section/Color Options/Background Color/Background Color Picker") as ColorPickerButton
	backgroundColorPicker.color = UserVariables.backgroundThemeColor
	var backgroundAccentColorPicker = get_node("ScrollContainer/VBoxContainer/Color Section/Color Options/Background Accent Color/Background Accent Color Picker") as ColorPickerButton
	backgroundAccentColorPicker.color = UserVariables.backgroundAccentColor
	var gridPrimaryColorPicker = get_node("ScrollContainer/VBoxContainer/Color Section/Color Options/Grid Primary Color/Grid Primary Color Picker") as ColorPickerButton
	gridPrimaryColorPicker.color = UserVariables.gridPrimaryColor
	var gridSecondaryColorPicker = get_node("ScrollContainer/VBoxContainer/Color Section/Color Options/Grid Secondary Color/Grid Secondary Color Picker") as ColorPickerButton
	gridSecondaryColorPicker.color = UserVariables.gridSecondaryColor
	var gridAccentColorPicker = get_node("ScrollContainer/VBoxContainer/Color Section/Color Options/Grid Accent Color/Grid Accent Color Picker") as ColorPickerButton
	gridAccentColorPicker.color = UserVariables.gridAccentColor
	
	var autoSecondaryButton = get_node("ScrollContainer/VBoxContainer/Color Section/Color Options/Grid Secondary Color/HSplitContainer/HSplitContainer/Auto Grid Secondary") as Button
	if autoSecondaryButton.button_pressed:
		gridSecondaryColorPicker.disabled = true
		var resetSecondaryButton = get_node("ScrollContainer/VBoxContainer/Color Section/Color Options/Grid Secondary Color/HSplitContainer/Reset Grid Secondary") as Button
		resetSecondaryButton.disabled = true


func _on_back_button_pressed():
	GameVariables.currentScreen = GameConstants.MAIN_MENU
