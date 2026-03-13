shader_type spatial;
render_mode unshaded, wireframe;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	ALBEDO = vec3(1.0, 0.5, 0.0); // Set the color of the asteroid to orange.
}
