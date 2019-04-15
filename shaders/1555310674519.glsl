vec4 pixel(vec2 p) {
    p /= resolution;
    vec2 q = p;
    p -= 0.5;
    p.x *= resolution.x / resolution.y;

    float mixer = min((time - 184.) * .1, 1.);

    vec2 text = q;
    text.y += texture(channel2, q).r * mixer * 5.;

    return mix(texture(channel1, text) - texture(channel2, q), texture(channel2, q), mixer * 2.);
}
