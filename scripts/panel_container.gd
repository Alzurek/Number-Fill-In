extends PanelContainer


func _on_visibility_changed():
	var colorPicker = get_node('VBoxContainer/MarginContainer/ColorPicker')
	match(SettingsVariables.colorPicking):
		SettingsConstants.BACKGROUND:
			colorPicker.color = UserVariables.backgroundThemeColor
		SettingsConstants.BACKGROUND_ACCENT:
			colorPicker.color = UserVariables.backgroundAccentColor
		SettingsConstants.GRID_PRIMARY:
			colorPicker.color = UserVariables.gridPrimaryColor
		SettingsConstants.GRID_SECONDARY:
			colorPicker.color = UserVariables.gridSecondaryColor
		SettingsConstants.GRID_ACCENT:
			colorPicker.color = UserVariables.gridAccentColor
