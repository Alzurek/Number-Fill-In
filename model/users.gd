extends Node

class_name User


var documentId : String
var email : String
var username : String
var password : String


func _init(_documentId : String, _email : String, _password : String, _username : String = ""):
	if _username == "":
		_username = _email.split('@')[0]
	documentId = _documentId
	email = _email
	username = _username
	password = _password


# The following do not work as factory methods.
# Determine if this is possible with some form of syntax
func fromFireStoreDoc(_documentId : String, fields : Dictionary):
	documentId = _documentId
	email = fields['email']
	username = fields['username']
	password = fields['password']


func getFirestoreFields():
	var fields = {}
	fields['email'] = email
	fields['username'] = username
	fields['password'] = password
	return fields


func toJSON():
	var json = {}
	json['documentId'] = documentId
	json['email'] = email
	json['username'] = username
	json['password'] = password
	return json
	

func fromJSON(json : Dictionary):
	documentId = json['documentId']
	email = json['email']
	username = json['username']
	password = json['password']
	return self
