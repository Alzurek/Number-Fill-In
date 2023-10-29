extends Node


func getAdditionOrSubtractionFormulaForNumber(number):
	var type = randi() % 2
	if type == 1:
		return getAdditionFormulaForNumber(number)
	else:
		return getSubtractionFormulaForNumber(number)


func getAdditionFormulaForNumber(number):
	return getEquation(number, 1)


func getSubtractionFormulaForNumber(number):
	return getEquation(number, -1)


func getEquation(number, type):
	var mod = max(1, MathService.integerDivision(number, 2))
	var b = randi() % (mod)
	var a = number + (type * b)
	var typeString = " + "
	if type == -1:
		typeString = " - "
	return {str(a) + typeString + str(b): number}


func integerDivision(a, b):
	return int(float(a) / float(b))
