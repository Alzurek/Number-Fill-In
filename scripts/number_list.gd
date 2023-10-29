extends ItemList


var initialLoad = true
var skipGroups = []
var currentItems = []
var defaultNumberIndexes = []


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# can use get_node("node name string") to get a node and its properties 
	# add_child()
	if initialLoad:
		skipGroups = GameVariables.numberLists.keys()

	var index = 0
	var headers = []
	var items = []
	var crossedOut = []
	defaultNumberIndexes = []

	if GameVariables.numberListUpdated || initialLoad:
		clear()
		var digitGroups = GameVariables.numberLists.keys()
		for digitGroup in digitGroups:
			# add digit group header
			add_item("--- " + str(digitGroup) + " ---", null, true)
			set_item_tooltip(index, "Digit Group " + str(digitGroup))
			headers.append(index)
			index += 1
			if !skipGroups.has(digitGroup):
				var numbers = GameVariables.numberLists.get(digitGroup)
				for number in numbers:
					if randi() % 2:
						add_item(number, null, false)
					else:
						add_item(number, null, false)
					set_item_tooltip_enabled(index, false)
					items.append(index)
					if GameVariables.crossedOutNumbers.has(number):
						crossedOut.append(index)
					if GameVariables.defaultNumbers.has(number):
						defaultNumberIndexes.append(index)
					index += 1
		initialLoad = false
		GameVariables.numberListUpdated = false
	crossedOut.append_array(defaultNumberIndexes)
	for header in headers:
		var group = int(get_item_text(header).split(" ")[1])
		if (GameVariables.finishedGroups.has(group)):
			# There still seems to be a small bug when clicking around a lot
			set_item_custom_fg_color(header, Color.DIM_GRAY)
		else:
			set_item_custom_fg_color(header, Color.FLORAL_WHITE)
	for item in items:
		if crossedOut.has(item):
			# determine if there is a way to edit the font style (strikethrough)
			set_item_custom_fg_color(item, Color.DIM_GRAY * .6)
		else:
			set_item_custom_fg_color(item, Color.DIM_GRAY)

func _on_item_selected(index):
	var text = get_item_text(index)
	if (text.split(" ").size() == 1): 
		if GameVariables.defaultNumbers.has(text): return
		if !GameVariables.crossedOutNumbers.has(text):
			GameVariables.crossedOutNumbers.append(text)
			print(GameVariables.crossedOutNumbers)
			var digitGroup = text.length()
			var filteredNumbers = GameVariables.crossedOutNumbers.filter(func(number): return number.length() == digitGroup)
			var numbersCrossedOutFromGroup = filteredNumbers.size()
			var totalAmountInGroup = GameVariables.numberLists.get(digitGroup)
			if numbersCrossedOutFromGroup == totalAmountInGroup.size():
				GameVariables.finishedGroups.append(digitGroup)
		else:
			GameVariables.crossedOutNumbers.erase(text)
			GameVariables.finishedGroups.erase(text.length())
		return
	var digitGroup = int(text.split(" ")[1])
	if skipGroups.has(digitGroup):
		skipGroups.erase(digitGroup)
	else:
		skipGroups.append(digitGroup)
	GameVariables.numberListUpdated = true
