shader_type canvas_item;

uniform bool flash = false;

void fragment() {
	vec4 texture_color = texture(TEXTURE,UV);
	if (flash) {
		vec3 coloor = vec3(1.0,0.2,0.0);
		vec3 flash_rgb = mix(texture_color.rgb, coloor, 0.8);
		COLOR = vec4(flash_rgb, texture_color.a);
	} else {
		COLOR = texture_color;
	}
}
