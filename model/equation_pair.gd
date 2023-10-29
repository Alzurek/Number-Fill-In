extends Node


class_name EquationPairs


var equation : String
var answer : int


func _init(_answer):
	equation = MathService.getAdditionOrSubtractionFormulaForNumber(_answer)
	answer = _answer
