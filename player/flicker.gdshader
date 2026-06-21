shader_type canvas_item;

uniform bool active = false;
uniform vec4 target_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 flash_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float tolerance = 0.1;

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    
    if (active) {
        if (distance(tex_color.rgb, target_color.rgb) < tolerance && tex_color.a > 0.0) {
            COLOR = vec4(flash_color.rgb, tex_color.a);
        } else {
            COLOR = tex_color;
        }
    } else {
        COLOR = tex_color;
    }
}