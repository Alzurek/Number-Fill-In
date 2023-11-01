extends Control


var email = ""
var password = ""

func _on_login_pressed():
	FirebaseService.doEmailLogin(email, password, self)


func _on_email_text_changed(new_text):
	email = new_text


func _on_password_text_changed(new_text):
	password = new_text.sha256_text()

