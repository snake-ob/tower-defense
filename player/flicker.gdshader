shader_type canvas_item;

uniform bool active = false;
uniform vec4 target_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 flash_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float tolerance = 0.1;

void fragment() {
    // 1. Store the incoming modulate color (shadow opacity/color)
    vec4 modulate_color = COLOR; 
    
    // 2. Get the raw texture pixel
    vec4 tex_color = texture(TEXTURE, UV);
    
    if (active) {
        if (distance(tex_color.rgb, target_color.rgb) < tolerance && tex_color.a > 0.0) {
            // Do NOT multiply by modulate_color here! 
            // This keeps the hit flash at 100% full, bright, solid color.
            COLOR = vec4(flash_color.rgb, tex_color.a);
        } else {
            // Outside of the flashed pixels, respect the shadow modulate
            COLOR = tex_color * modulate_color;
        }
    } else {
        // Normal state: apply the shadow modulate
        COLOR = tex_color * modulate_color;
    }
}