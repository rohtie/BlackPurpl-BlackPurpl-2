vec4 pixel(vec2 p) {
    p /= resolution;
    p -= 0.5;

    p.x *= resolution.x / resolution.y;

    p.x += sin(p.y * 5.0 + time);

    float r = length(mod(p, 0.2)) -0.2;
    r = smoothstep(0., 0.001, r);

    return vec4(r);
}
