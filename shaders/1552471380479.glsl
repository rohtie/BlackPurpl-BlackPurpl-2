vec4 pixel(vec2 p) {
    p /= resolution;
    vec2 q = p;

    p -= 0.5;
    p.x *= resolution.x / resolution.y;

    p.x *= texture(channel1, p - 0.5).r * 10.;

    return texture(channel0, p);
}
