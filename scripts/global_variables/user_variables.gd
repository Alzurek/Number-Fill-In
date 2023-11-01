extends Node


var currentUser : User

const defaultBackgroundThemeColor = Color("#141414")
const defaultBackgroundAccentColor = Color("#1312f554")
const defaultGridPrimaryColor = Color(1, 1, 1)
const defaultGridSecondaryColor = Color("black")
const defaultGridAccentColor = Color(0.25, 0.94, 0.97, 0.37)


# Theme attributes, look into making a class or maybe a map for this
var backgroundThemeColor = defaultBackgroundThemeColor
var backgroundAccentColor = defaultBackgroundAccentColor
var gridPrimaryColor = defaultGridPrimaryColor
var gridSecondaryColor = defaultGridSecondaryColor
var gridAccentColor = defaultGridAccentColor

var useInvertedGridSecondary = false
