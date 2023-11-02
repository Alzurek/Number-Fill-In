extends Control


func _on_reset_background_pressed():
	UserVariables.backgroundThemeColor = UserVariables.defaultBackgroundThemeColor
	updateBackgroundThemeColors()


func _on_reset_background_accent_pressed():
	UserVariables.backgroundAccentColor = UserVariables.defaultBackgroundAccentColor
	updateBackgroundAccentColors()


func _on_reset_grid_primary_pressed():
	UserVariables.gridPrimaryColor = UserVariables.defaultGridPrimaryColor
	updateGridPrimaryColors()


func _on_reset_grid_secondary_pressed():
	UserVariables.gridSecondaryColor = UserVariables.defaultGridSecondaryColor
	updateGridSecondaryColors()


func _on_reset_grid_accent_pressed():
	UserVariables.gridAccentColor = UserVariables.defaultGridAccentColor
	updateGridAccentColors()
	
	
func updateColorPickerButton(container : String, color : Color):
	var colorPicker = get_node("Color Options/" + container + "/Control/Color Display") as Button
	
	var buttonTheme = colorPicker.get_theme_stylebox("normal") as StyleBox
	buttonTheme.bg_color = color
	colorPicker.remove_theme_stylebox_override("normal")
	colorPicker.add_theme_stylebox_override("normal", buttonTheme)


func _on_auto_grid_secondary_toggled(button_pressed):
	UserVariables.useInvertedGridSecondary = button_pressed
	
	var gridSecondaryColorPicker = get_node("Color Options/Grid Secondary Color/Control/Color Display") as Button
	gridSecondaryColorPicker.color = UserVariables.gridPrimaryColor.inverted()
	gridSecondaryColorPicker.disabled = button_pressed
	
	var resetSecondaryButton = get_node("Color Options/Grid Secondary Color/HSplitContainer/Reset Grid Secondary") as Button
	resetSecondaryButton.disabled = button_pressed


func _on_color_picker_color_changed(color):
	match(SettingsVariables.colorPicking):
		SettingsConstants.BACKGROUND:
			UserVariables.backgroundThemeColor = color
			updateBackgroundThemeColors()
		SettingsConstants.BACKGROUND_ACCENT:
			UserVariables.backgroundAccentColor = color
			updateBackgroundAccentColors()
		SettingsConstants.GRID_PRIMARY:
			UserVariables.gridPrimaryColor = color
			updateGridPrimaryColors()
		SettingsConstants.GRID_SECONDARY:
			UserVariables.gridSecondaryColor = color
			updateGridSecondaryColors()
		SettingsConstants.GRID_ACCENT:
			UserVariables.gridAccentColor = color
			updateGridAccentColors()


func _on_set_color_pressed():
	hideColorPicker()
	SettingsVariables.colorPicking = null


func _on_background_color_display_pressed():
	SettingsVariables.colorPicking = SettingsConstants.BACKGROUND
	showColorPicker()
	updateColorPickerButton("Background Color", UserVariables.backgroundThemeColor)


func _on_background_accent_color_display_pressed():
	SettingsVariables.colorPicking = SettingsConstants.BACKGROUND_ACCENT
	showColorPicker()
	updateColorPickerButton("Background Accent Color", UserVariables.backgroundAccentColor)


func _on_grid_primary_color_display_pressed():
	SettingsVariables.colorPicking = SettingsConstants.GRID_PRIMARY
	showColorPicker()
	updateColorPickerButton("Grid Primary Color", UserVariables.gridPrimaryColor)


func _on_grid_secondary_color_display_pressed():
	SettingsVariables.colorPicking = SettingsConstants.GRID_SECONDARY
	showColorPicker()
	updateColorPickerButton("Grid Secondary Color", UserVariables.gridSecondaryColor)


func _on_grid_accent_color_display_pressed():
	SettingsVariables.colorPicking = SettingsConstants.GRID_ACCENT
	showColorPicker()
	updateColorPickerButton("Grid Accent Color", UserVariables.gridAccentColor)


func showColorPicker():
	var node = get_node('../../../PanelContainer')
	node.set_visible(true)


func hideColorPicker():
	var node = get_node('../../../PanelContainer')
	node.set_visible(false)


func updateBackgroundThemeColors():
	updateColorPickerButton("Background Color", UserVariables.backgroundThemeColor)
	MainService.updateBackgroundThemeColors()


func updateBackgroundAccentColors():
	updateColorPickerButton("Background Accent Color", UserVariables.backgroundAccentColor)
	MainService.updateBackgroundAccentColors()


func updateGridPrimaryColors():
	updateColorPickerButton("Grid Primary Color", UserVariables.gridPrimaryColor)
	MainService.updateGridPrimaryColors()


func updateGridSecondaryColors():
	updateColorPickerButton("Grid Secondary Color", UserVariables.gridSecondaryColor)
	MainService.updateGridSecondaryColors()


func updateGridAccentColors():
	updateColorPickerButton("Grid Accent Color", UserVariables.gridAccentColor)
	MainService.updateGridAccentColors()
