extends Node


func updateAllColors():
	updateBackgroundThemeColors()
	updateBackgroundAccentColors()
	updateGridPrimaryColors()
	updateGridSecondaryColors()
	updateGridAccentColors()


func updateBackgroundThemeColors():
	var background = get_node('/root/Main/Custom Background') as Polygon2D
	background.color = UserVariables.backgroundThemeColor


func updateBackgroundAccentColors():
	var backgroundAccent = get_node('/root/Main/Custom Background Accent') as Polygon2D
	backgroundAccent.vertex_colors = PackedColorArray([
		UserVariables.backgroundAccentColor,
		Color.TRANSPARENT,
		Color.TRANSPARENT,
		UserVariables.backgroundAccentColor
	])
	
	#var userInfoBar = get_node(('/root/Main/User Info/Username Bar')) as Panel
	# Todo color the borders of the username area.


func updateGridPrimaryColors():
	pass


func updateGridSecondaryColors():
	pass


func updateGridAccentColors():
	pass


func updateColorPickerButton(container : String, theme : String, color : Color):
	var colorPicker = get_node("/root/SettingsScene/ScrollContainer/VBoxContainer/Color Section/Color Options/" + container + "/Color Display") as Button
						#	   'ScrollContainer/VBoxContainer/Color Section/Color Options/Background Color/Color Display'
	var buttonTheme = colorPicker.get_theme_stylebox(theme) as StyleBox
	buttonTheme.bg_color = color
	colorPicker.remove_theme_stylebox_override(theme)
	colorPicker.add_theme_stylebox_override(theme, buttonTheme)
	
	
func updateGridColors():
	var boardBackground = get_node('/root/GameScene/Game Canvas/Board Background') as Polygon2D
	boardBackground.color = UserVariables.gridPrimaryColor
	var boardSecondary = get_node('/root/GameScene/Grid Secondary Background') as Polygon2D
	boardSecondary.color = UserVariables.gridSecondaryColor
