vec4 pixel(vec2 p) {
    p /= resolution;
    vec2 q = p;

    p -= 0.5;
    p.x *= resolution.x / resolution.y;

    p.x -= texture(channel2, q).r;

    float r = p.x;
    r = smoothstep(-0.2, 0.2, r);

    return texture(channel0, q) * r + texture(channel1, q) * (1. - r);
}
