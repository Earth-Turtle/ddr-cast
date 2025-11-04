extends HBoxContainer

const directions: Dictionary[String, Texture] = {
	"spell_input_left": preload("res://icons/arrow_outline_left.png"),
	"spell_input_up": preload("res://icons/arrow_outline_up.png"),
	"spell_input_right": preload("res://icons/arrow_outline_right.png"),
	"spell_input_down": preload("res://icons/arrow_outline_down.png"),
}

signal input_complete(inputs: Array[TextureRect])

func _input(event: InputEvent) -> void:
	if event.is_action_released("spell_input_down"):
		var texture_rect = TextureRect.new()
		texture_rect.texture = directions["spell_input_down"]
		add_child(texture_rect)
	elif event.is_action_released("spell_input_left"):
		var texture_rect = TextureRect.new()
		texture_rect.texture = directions["spell_input_left"]
		add_child(texture_rect)
	elif event.is_action_released("spell_input_right"):
		var texture_rect = TextureRect.new()
		texture_rect.texture = directions["spell_input_right"]
		add_child(texture_rect)
	elif event.is_action_released("spell_input_up"):
		var texture_rect = TextureRect.new()
		texture_rect.texture = directions["spell_input_up"]
		texture_rect.expand_mode = TextureRect.EXPAND_KEEP_SIZE
		texture_rect.stretch_mode = TextureRect.STRETCH_KEEP
		add_child(texture_rect)
	elif event.is_action_released("ui_accept"):
		input_complete.emit(get_children())
		for n in get_children():
			n.queue_free()
