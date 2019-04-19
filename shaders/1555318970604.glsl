vec4 pixel(vec2 p) {
    p /= resolution;
    vec2 q = p;
    p -= 0.5;
    p.x *= resolution.x / resolution.y;

    float mixer = clamp(time - 160., 0., 1.0);


    vec2 text = q;
    // text.x += texture(channel2, q).r * mixer;

    return mix(texture(channel1, text), texture(channel2, q), mixer * 15.);
}
