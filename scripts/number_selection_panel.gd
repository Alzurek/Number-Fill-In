extends Panel


func _ready():
	var stylebox = StyleBoxFlat.new()
	get_theme_stylebox("panel").bg_color = UserVariables.gridAccentColor
	stylebox.border_width_left = 3
	stylebox.border_color = Color(0, 1, 0.5)
