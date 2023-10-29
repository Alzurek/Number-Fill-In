extends Node


const gameStarted = "started"
const gameInProgress = "inProgress"
const gameComplete = "complete"


const gridSize = 510
const tileSize = 256


# Difficulty
enum {EASY, MEDIUM, HARD, EXPERT}


# Screens
enum {
	MAIN_MENU,
	DIFFICULTY_MENU,
	SETTINGS_MENU,
	GAME_SCREEN,
	WIN_VIEW
}


# special functions scene physics
enum {GAME_CREATION, GAME_COMPLETION}


# board sizes
enum {THIRTEEN, FIFTEEN, NINETEEN, TWENTY_ONE}


# layers of game grid
enum {BOARD_LAYER, NUMBER_LAYER, NOTE_LAYER}
