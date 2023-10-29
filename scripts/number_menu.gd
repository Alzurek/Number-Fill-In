extends Control


func _on_button_0_pressed():
	onButtonPress(0)


func _on_button_1_pressed():
	onButtonPress(1)


func _on_button_2_pressed():
	onButtonPress(2)


func _on_button_3_pressed():
	onButtonPress(3)


func _on_button_4_pressed():
	onButtonPress(4)


func _on_button_5_pressed():
	onButtonPress(5)


func _on_button_6_pressed():
	onButtonPress(6)


func _on_button_7_pressed():
	onButtonPress(7)


func _on_button_8_pressed():
	onButtonPress(8)


func _on_button_9_pressed():
	onButtonPress(9)


func onButtonPress(button):
	print("Setting " + str(button))
	GameVariables.currentNumber = button
