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


func updateGridColors():
	var boardBackground = get_node('/root/GameScene/Game Canvas/Board Background') as Polygon2D
	boardBackground.color = UserVariables.gridPrimaryColor
	var boardSecondary = get_node('/root/GameScene/Grid Secondary Background') as Polygon2D
	boardSecondary.color = UserVariables.gridSecondaryColor

