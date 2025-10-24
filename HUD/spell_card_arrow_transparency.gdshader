shader_type canvas_item;

/**
 * Float between 0 and 1, where 1 is fully opaque, and 0 is fully transparent
 */
uniform float transparency = 0.2;

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 input = texture(TEXTURE, UV);
	COLOR = vec4(input.r, input.g, input.b, input.a * transparency);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
