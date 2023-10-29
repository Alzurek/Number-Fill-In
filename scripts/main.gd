extends Node


@onready var collection : FirestoreCollection = Firebase.Firestore.collection('testCollection')


func _ready():
	MainService.updateAllColors()
	# testFirebase()


func testFirebase():
	print("Beginning Firebase testing...\n")
	
	Firebase.Auth.get_google_auth_manual()
	var document_task : FirestoreTask = collection.get_doc('firstDocument')
	var document : FirestoreDocument = await document_task.get_document
	
	print(document)
	# Make an Object and find a good library for JSON <-> (Dictionary) <-> Object
	# Preferably straight from JSON to object
	# might just have to make factory methods and not use libraries in this case.
	
	print("Finishing Firebase testing")
