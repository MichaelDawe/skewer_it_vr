shader_type spatial;
render_mode unshaded, blend_add;

void fragment() {
	ALBEDO = vec3(0.3, 0.6, 0.9) * NORMAL.z;
}
