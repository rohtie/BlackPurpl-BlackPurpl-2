
float caps( vec3 p, vec3 a, vec3 b, float r ) {
    vec3 pa = p - a, ba = b - a;
    float h = clamp( dot(pa,ba)/dot(ba,ba), 0.0, 1.0 );
    return length( pa - ba*h ) - r;
}

float map(vec3 p) {
    // p.xz *= rotate(acos(-1.));
    // p.xyz += sin(p.y * 10.);
    // p.xz *= rotate(p.y);

    // p += sin(p.xyz * 0.) * 0.2;

    p += sin(p.yxz + time * 2.) * .2;


    float r = length(p) - 0.75 - tan(sin(time) + time * 0.1 + 2.) * .25;

    return r;
}

vec4 pixel(vec2 p) {
    float time = time + 2500.0;

    p /= resolution;
    vec2 q = p;
    p -= .5;
    p.x *= resolution.x / resolution.y;


    vec3 ray = vec3(p, -1.);
    vec3 cam = vec3(0., 0., 5.);

    float dist = 0.;

    for (int i=0; i<100; i++) {
        vec3 p = cam + ray * dist;

        float tmp = map(p);

        if (tmp < 0.001) {
            // return vec4(dist * 0.05);
            // return vec4(1.);
            return 1. - (vec4(0.6 - p.x + sin(p.y * 5.) * 0.3, 0.15, p.x * 0.6 + sin(p.y * 5.) * 0.3, 0.));
        }

        if (dist > 7.) {
            break;
        }

        dist += tmp;
    }



    p.x += tan(p.y * 2.);

    p.y += cnoise(vec3(q * 5., time * .01)) * 0.2;
    p.y += cnoise(vec3(q * 50., 0.)) * 0.1;
    p.y += cnoise(vec3(q * 100., 0.)) * 0.01;



    p.x += p.y * 20.;

    float r = length(p) - 0.25 + sin(time * 50.);
    r = 1. - r;

    if (r < 0.5) {
        q *= 0.999;
        q += 0.001;
        return 1. - texture(channel0, q) * vec4(0.99, 1.05, 1.01, 0.);
    }


    return vec4(cnoise(vec3(q * 300., time * 10.)));
}
