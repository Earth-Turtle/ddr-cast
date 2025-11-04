
## Data class for holding a sequence of inputs for a spell. 
class_name SpellInput extends RefCounted

var input_pattern: Array[ComplexityCalculator.Direction] = []
## Always greater than or equal to 1
var complexity: float = -1.0

func _init(inputs: Array[ComplexityCalculator.Direction]) -> void:
	self.inputs = inputs
	self.complexity = ComplexityCalculator.complexity_analysis(inputs)
