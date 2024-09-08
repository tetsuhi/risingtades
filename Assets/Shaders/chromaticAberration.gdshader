shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_nearest;

uniform float aberration : hint_range(0.0, 10.0) = 1.0;

void fragment() {
	
	float red = texture(SCREEN_TEXTURE, vec2(SCREEN_UV.x + SCREEN_PIXEL_SIZE.x * aberration, SCREEN_UV.y), 0.0).r;
	float green = texture(SCREEN_TEXTURE, SCREEN_UV, 0.0).g;
	float blue = texture(SCREEN_TEXTURE, vec2(SCREEN_UV.x + SCREEN_PIXEL_SIZE.x * -aberration, SCREEN_UV.y), 0.0).b;
	
	vec2 screen_center = vec2(SCREEN_PIXEL_SIZE + 0.5);
	float center_distance = length(screen_center - SCREEN_UV);
	
	float alpha = smoothstep(0.0, 1.0, center_distance);
	
	COLOR = vec4(red, green, blue, alpha);
	
}