class_name ComplexityCalculator
extends RefCounted

static func complexity_analysis(path: String) -> float:
	var lzv_arr = lzv(path)
	var lzv_encoded_length = lzv_arr[0]
	var lzv_dict_size = lzv_arr[1]
	var entropy = string_entropy(path)
	
	var complexity = (1.0 * lzv_encoded_length) * (1.0 * lzv_dict_size) * (1.0 * (entropy + 1)) * (1.0 * path.length())
	return complexity

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
		if char_count == 0: continue
		var char_probability = float(char_count) / input.length()
		entropy += char_probability * log(char_probability) / log(2)
	return -entropy
	
## Adaptation of Lempel-Ziv-Welch encoding to determine the "compressability" of a string
## Returns a 2-element array: the length of the output encoded string, and the length of the dictionary
static func lzv(input: String) -> Array[int]:
	var dict = {}
	const possible_dirs = ["L", "U", "R", "D"]
	for dir in possible_dirs:
		if input.contains(dir):
			dict[dir] = dict.size()
	
	var working_string = ""
	var output_codes = []
	for c in input:
		if dict.has(working_string + c):
			working_string += c
		else:
			output_codes.append(dict[working_string])
			dict[working_string + c] = str(dict.size())
			working_string = c
	
	output_codes.append(dict[working_string])
	
	return [output_codes.size(), dict.size()]
	
const test_patterns = [
	"R",
	"U",
	"L",
	"RR",
	"RU",
	"LL",
	"UD",
	"RRR",
	"URL",
	"RLD",
	"RLR",
	"UDU",
	"RDULUL",
	"RLRLR",
	"RLRLRL",
	"RLRL",
	"URDLURDL",
	"ULRDULRD",
	"RLUDRL",
	"RLUDRR",
	"RRLU",
	"LURR",
	"LRRU",
	"RDULRUDLLUDR",
	"LDURLDLDURDLDLLR",
	"DDDDRRRRLUUUUU",
	"URURURURURURURURURURUR",
	"RRRR",
	"RRRRR",
	"RRRRRR",
	"RRRRRRR",
	"RRRRRRRR",
	"RRRRRRRRR",
	"RRRRRRRRRR",
	"RRRRRRRRRRR",
]

static func test():
	var complexities = test_patterns.map(func (p): return [p, complexity_analysis(p)])
	complexities.sort_custom(func (a, b): return a[1] > b[1])
	for entry in complexities:
		print(entry)
