extends Control

@onready var container = $Container

func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("spell_input_down") 
		or event.is_action_pressed("spell_input_left") 
		or event.is_action_pressed("spell_input_right") 
		or event.is_action_pressed("spell_input_up")):
	
		var texture_rect = TextureRect.new()
		if event.is_action_pressed("spell_input_left"):
			texture_rect.texture = load("res://icons/gravity-ui--arrow-shape-left.png")
		elif event.is_action_pressed("spell_input_right"):
			texture_rect.texture = load("res://icons/gravity-ui--arrow-shape-right.png")
		elif event.is_action_pressed("spell_input_down"):
			texture_rect.texture = load("res://icons/gravity-ui--arrow-shape-down.png")
		else:
			texture_rect.texture = load("res://icons/gravity-ui--arrow-shape-up.png")

		container.add_child(texture_rect)
	elif event.is_action_pressed("clear_spell"):
		for child in container.get_children():
			child.queue_free()
