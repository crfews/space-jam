shader_type spatial;
render_mode unshaded, wireframe;

uniform vec4 asteroid_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);

void fragment() {
	ALBEDO = asteroid_color.rgb;
}