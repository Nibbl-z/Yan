extern vec4 textcolor;
extern vec4 bordercolor;

vec4 effect ( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ) {
    vec4 pixel = Texel(texture, texture_coords);

    if (pixel.a == 0.0) {
        return vec4(0.0,0.0,0.0,0.0);
    }

    if (pixel.a > 0.0 && pixel.a < 0.7) {
        return vec4(bordercolor.r, bordercolor.g, bordercolor.b, pixel.a);
    }

    return vec4(textcolor.r, textcolor.g, textcolor.b, pixel.a);
}