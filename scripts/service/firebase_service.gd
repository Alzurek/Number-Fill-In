extends Node


var testCollection : FirestoreCollection
var testExpires = 0

var userCollection : FirestoreCollection
var userExpires = 0

var signalsSet = false

var loginScene
var email
var password

func doEmailLogin(_email : String, _password : String, scene):
	email = _email
	password = _password
	loginScene = scene
	if not signalsSet:
		Firebase.Auth.login_failed.connect(loginFailed)
		Firebase.Auth.login_succeeded.connect(loginSuccess)
		Firebase.Auth.signup_failed.connect(signupFailed)
		Firebase.Auth.signup_succeeded.connect(signupSuccess)
	Firebase.Auth.login_with_email_and_password(email, password)


func loginSuccess(result):
	print(result)
	# get user doc using userId
	GameVariables.currentScreen = GameConstants.MAIN_MENU
	var userDoc = await getUserByDocumentId(result['localid'])
	UserVariables.currentUser = User.new(
		result['localid'],
		userDoc.doc_fields['email'],
		userDoc.doc_fields['password'],
		userDoc.doc_fields['username']
	)
	print('Logged in')


func loginFailed(code, err):
	logError('login', code, err)
	Firebase.Auth.signup_with_email_and_password(email, password)


func signupSuccess(result):
	GameVariables.currentScreen = GameConstants.MAIN_MENU
	UserVariables.currentUser = createAccount(result['localid'])


func createAccount(token : String):
	var newUser = User.new(token, email, password)
	addNewUser(newUser)
	print('Account created')
	return newUser


func signupFailed(code, err):
	# assuming failed means that already exists, therefore the original login also didnt work
	logError('signup', code, err)
	var node = loginScene.get_node('VBoxContainer/Incorrect Credentials Display') as MarginContainer
	node.visible = true
	print('Invalid credentials')
	# potentially could be a real error, if so display this error


func refreshUserCollection():
	if userCollection == null and userExpires < Time.get_ticks_msec():
		userCollection = Firebase.Firestore.collection('users')
		userExpires = Time.get_ticks_msec() + 360000 # 1 hour


func getUserByDocumentId(docId):
	refreshUserCollection()
	var task : FirestoreTask = userCollection.get_doc(docId)
	var doc = await task.get_document as FirestoreDocument
	return doc


func addNewUser(user : User):
	refreshUserCollection()
	var task : FirestoreTask = userCollection.add(user.documentId, user.getFirestoreFields())
	return await task.task_finished as FirestoreDocument


func logError(type, code, err):
	print(type + ' failed: ' + str(code))
	print(err)
	print(' ---------- ')
