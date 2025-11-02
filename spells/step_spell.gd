## A step spell means that the spell changes behavior at discrete points. 
## For example, 1x damage at 1-2 complexity, 2x damage at 2-3 complexity, etc. 
## STEP scaling will ask to calculate a "progress" to the next step so it
## can be displayed in UI
@abstract class_name StepSpell extends BaseSpell

class ComplexityProgress:
	## A proportion between 0 and 1, showing how far the complexity is to reaching the next level
	var progress: float
	## What "step" of the progression this spell is at at based on the complexity. Between 1 and max_step
	var step: int
	## The maximum step possible for this spell
	var max_step: int
	
## Returns a float from 0 to 1 indicating how close the level of complexity is to reaching the next
## "step" of the spell. The spell can have 
@abstract
func complexity_progress_to_next_step(complexity: float) -> ComplexityProgress

@abstract
func get_description_text()
