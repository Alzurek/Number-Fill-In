extends Control


func _on_back_button_pressed():
	GameVariables.currentScreen = GameConstants.MAIN_MENU


func _on_background_color_picker_color_changed(color):
	UserVariables.backgroundThemeColor = color
	MainService.updateBackgroundThemeColors()


func _on_background_accent_color_picker_color_changed(color):
	UserVariables.backgroundAccentColor = color
	MainService.updateBackgroundAccentColors()


func _on_grid_primary_color_picker_color_changed(color):
	UserVariables.gridPrimaryColor = color
	MainService.updateGridPrimaryColors()


func _on_grid_secondary_color_picker_color_changed(color):
	UserVariables.gridSecondaryColor = color
	MainService.updateGridSecondaryColors()


func _on_grid_accent_color_picker_color_changed(color):
	UserVariables.gridAccentColor = color
	MainService.updateGridAccentColors()


func _on_reset_background_pressed():
	UserVariables.backgroundThemeColor = UserVariables.defaultBackgroundThemeColor
	MainService.updateBackgroundThemeColors()


func _on_reset_background_accent_pressed():
	UserVariables.backgroundAccentColor = UserVariables.defaultBackgroundAccentColor
	MainService.updateBackgroundAccentColors()


func _on_reset_grid_primary_pressed():
	UserVariables.gridPrimaryColor = UserVariables.defaultGridPrimaryColor
	MainService.updateGridPrimaryColors()


func _on_reset_grid_secondary_pressed():
	UserVariables.gridSecondaryColor = UserVariables.defaultGridSecondaryColor
	var gridSecondaryColorPicker = get_node("Color Options/Grid Secondary Color/Grid Secondary Color Picker") as ColorPickerButton
	gridSecondaryColorPicker.color = UserVariables.gridSecondaryColor
	MainService.updateGridSecondaryColors()


func _on_reset_grid_accent_pressed():
	UserVariables.gridAccentColor = UserVariables.defaultGridAccentColor
	MainService.updateGridAccentColors()


func _on_auto_grid_secondary_toggled(button_pressed):
	UserVariables.useInvertedGridSecondary = button_pressed
	
	var gridSecondaryColorPicker = get_node("Color Options/Grid Secondary Color/Grid Secondary Color Picker") as ColorPickerButton
	gridSecondaryColorPicker.color = UserVariables.gridPrimaryColor.inverted()
	gridSecondaryColorPicker.disabled = button_pressed
	
	var resetSecondaryButton = get_node("Color Options/Grid Secondary Color/HSplitContainer/Reset Grid Secondary") as Button
	resetSecondaryButton.disabled = button_pressed
