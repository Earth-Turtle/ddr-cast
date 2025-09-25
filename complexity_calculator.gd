extends RefCounted

const length_modifier = 0.1

static func complexity_analysis(path: String) -> float:
	return 0.0
	
## Calculates the Shannon entropy of a given string
static func string_entropy(input: String) -> float:
	var counts = {
		"R": input.countn("R"),
		"U": input.countn("U"),
		"L": input.countn("L"),
		"D": input.countn("D"),
	}
	var entropy = 0.0
	for character in counts:
		var char_count = counts[character]
		var char_probability = float(char_count) / input.length()
		entropy += char_probability * log(char_probability)
	return -entropy
	
static func internal_patterns(input: String) -> Dictionary[String, int]:
	var ret = {}
	
	return ret
