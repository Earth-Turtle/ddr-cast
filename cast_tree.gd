class_name CastTree
extends RefCounted

enum Direction{
	LEFT,
	UP,
	RIGHT,
	DOWN
}

static func direction_to_string(dir: Direction) -> String:
	assert(Direction.has(dir), "That's not a direction, what are you doing")
	match dir:
		Direction.LEFT: return "L"
		Direction.UP: return "U"
		Direction.RIGHT: return "R"
		_: return "D"

class CastTreeNode:
	var next_inputs: Dictionary[Direction, CastTreeNode] = {}
	var augment: Augment
	
## The current status of a cast, as of the most recent input
class CastStatus:
	## A list of the cast inputs so far, from first to most recent
	var current_path: Array[Direction]
	## The timing of each input, as milliseconds since the engine started
	var input_timings: Array[int]
	## The timing of each input, as milliseconds since the previous input was given. 
	## The first element will always be 0
	var input_timing_diffs: Array[int]
	
	
