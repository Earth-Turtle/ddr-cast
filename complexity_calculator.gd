class_name ComplexityCalculator
extends Node

enum Direction {RIGHT, UP, LEFT, DOWN, UPPER_RIGHT, LOWER_RIGHT, UPPER_LEFT, LOWER_LEFT}

const directions = ["R", "U", "L", "D"]
const e = 2.718281828459045235360287471352
const compressability_factor = 0.5
const no_repeats_factor = 0.8
const entropy_factor = 0.5

static func complexity_analysis_dir_arr(path: Array[Direction]) -> float:
	var converted = ""
	for dir in path:
		match dir:
			Direction.RIGHT: converted += "R"
			Direction.UP: converted += "U"
			Direction.LEFT: converted += "L"
			Direction.DOWN: converted += "D"
	return complexity_analysis(converted)
	
	
## The full, headache-inducing complexity function. Takes in a string consisting of only R, U, L, and D characters
## Returns a float rounded to two decimal places
static func complexity_analysis(path: String) -> float:
	return snappedf(
		base_length_multiplier(path) * (
			(((compressability_multiplier(path) - 1) * compressability_factor) + 1)
			* (((no_repeats_bonus(path) - 1) * no_repeats_factor) + 1)
			* (1 + (pattern_entropy(path) * entropy_factor / 2))
		) ** 1.3
	, 0.01)

## Calculates the Shannon entropy of a given string
static func pattern_entropy(input: String) -> float:	
	var entropy = 0.0
	for dir in directions:
		var char_count = input.countn(dir)
		if char_count == 0: continue
		var char_probability = float(char_count) / input.length()
		entropy -= char_probability * log(char_probability) / log(2)
	return entropy
	
## Adaptation of Lempel-Ziv-Welch encoding to determine the "compressability" of a string
## Returns a 2-element array: the length of the output encoded string, and the length of the dictionary
static func lempel_ziv(input: String) -> Array[int]:
	var encoding_dict = {}
	for dir in directions:
		if input.contains(dir):
			encoding_dict[dir] = str(encoding_dict.size())
	
	var working_string = ""
	var output_codes = []
	for c in input:
		if encoding_dict.has(working_string + c):
			working_string += c
		else:
			output_codes.append(encoding_dict[working_string])
			encoding_dict[working_string + c] = str(encoding_dict.size())
			working_string = c
	
	output_codes.append(encoding_dict[working_string])
	return [output_codes.size(), encoding_dict.size()]
	
static func base_length_multiplier(input: String) -> float:
	return (input.length() - 1) * 0.1 + 1	

static func compressability_multiplier(input: String) -> float:
	var frac = input.length() / (1.0 + input.length() - lempel_ziv(input)[0])
	return log(9 + max(1, frac)) / log(10)
	
#region repeated letters bonus

static func count_repeated_letters(input: String) -> int:
	if input.length() == 0 or input.length() == 1: return 0
	var count = 0
	for i in range(input.length() - 1):
		if input[i] == input[i+1]: count += 1
	return count

## The lowest the bonus could be (asymptotically). 1 is good, can be lower to reduce the chance that any bonus is given for many repeats
const lower_bound = 0.97
## How fast the maximum bonus scales based on length. This is an exponent, should keep this between 1 and 2, leaning 1
const max_bonus_scaling = 1.3
## At what length should the no-repeats bonus be 2
const length_for_double = 18.0
## From 0 to 1, where 1 is the whole string as one repeated input, where half of the bonus should be received.
## E.g., 0.2 means half of the max possible bonus is received when 20% of the string has repeated inputs
const proportion_for_half_bonus = 0.2
## Steepness of the curve. Higher values make the curve steeper, and flatten the asymptotic approach on either side of the midpoint.
## Must be greater than 0
const steepness = 1.25
## Additional parameter for controlling character of the curve. > 0
const skew = 1.5

static func no_repeats_bonus(input: String) -> float:
	var upper_bound = 1.0 + ((input.length() / length_for_double) ** max_bonus_scaling)
	# intermediate variable so it doesn't get too hairy
	var mid_shift_inside_ln = (((upper_bound - lower_bound) ** skew) / ((((upper_bound + lower_bound) / 2.0) - lower_bound) ** skew)) - 1
	var mid_shift = input.length() * proportion_for_half_bonus - (1.0 / steepness) * log(mid_shift_inside_ln)
	
	var exponent = steepness * (count_repeated_letters(input) - mid_shift)
	var bottom_of_frac = (1 + e ** exponent) ** (1 / skew)
	return max(1, lower_bound + ((upper_bound - lower_bound) / bottom_of_frac))

#endregion
