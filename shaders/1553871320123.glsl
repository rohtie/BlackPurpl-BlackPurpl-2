
float caps( vec3 p, vec3 a, vec3 b, float r ) {
    vec3 pa = p - a, ba = b - a;
    float h = clamp( dot(pa,ba)/dot(ba,ba), 0.0, 1.0 );
    return length( pa - ba*h ) - r;
}

float map(vec3 p) {

    p.y += sin(p.x * 0.2 + time) * 1.26;
    p.y += sin(p.z * 0.1 + time * 0.2) * 0.5;

    float superTime = clamp((time - 116.) * .1, 0., 5.0);
    float extraTime = max(0., (time - 122.) * 10.);

    p.y += tan(p.z * 5.) * superTime * (1. + extraTime * .005);

    p.y += 1.75 + superTime * 6.;

    p.y += cnoise(vec3(p.xz * 4. - time * 2., 0.)) * .2;


    // p.y += texture(channel2, p.xz * 0.0125 - time * 0.015).r * 0.9;
    return p.y * .2;
}

vec4 pixel(vec2 p) {
    float time = time + 92500.0;


    p /= resolution;
    vec2 q = p;
    p.y = 1. - p.y;
    p -= .5;
    p.x *= resolution.x / resolution.y;

    // p.y = (1. - p.y);

    p.y = (1. - p.y) - 1.0;


    vec3 ray = vec3(p, -1.);
    vec3 cam = vec3(0., 0., 5.);

    ray.yz *= rotate(1.5 + sin(time * 0.2) * 0.1);
    cam.yz *= rotate(1.5 + sin(time * 0.2) * 0.1);

    float dist = 0.;

    for (int i=0; i<100; i++) {
        vec3 p = cam + ray * dist;

        float tmp = map(p);

        if (tmp < 0.01) {
            return ((
                vec4(dist * 0.2, dist * 0.9, dist * 0.2, 0.)
                * cnoise(vec3(p.xz * 0.1 + time * .5, 0.)) * 5.

                + vec4(p.z * 0.2, 0., -abs(sin(p.x) * 0.5), 0.)
            ) - p.z * 0.3) * 0.1 + vec4(p.z * 1., 0., abs(p.x), 0.) * 0.075 - hash(p.zx) * .2;
        }

        if (dist > 30.) {
            break;
        }

        dist += tmp;
    }


    p.x += cnoise(vec3(q * 2. * rotate(time * 0.15) - time * 0.15, 0.)) * .6;
    p.x += cnoise(vec3(q * 15. * rotate(time * 0.2) - time * 0.15, 0.)) * .1;
    p.x += cnoise(vec3(q * 20. * rotate(time * 0.3) - time * 0.15, 0.)) * .35;
    p.x += cnoise(vec3(q * 50. * rotate(time * 0.2) - time * 0.15, 0.)) * .23;
    p.x += cnoise(vec3(q * 2000. * rotate(time * 0.2) - time * 0.15, 0.)) * .3;

    p.x += tan(p.x * 1.28 + time * 5.);
    p.x += sin(p.y * 9.65 + time * 20.) * .5;


    float r = length(max(abs(p) - 0.3, 0.)) - 0.01;

    if (r > 0.8) {
        q.y -= 0.001;
        return texture(channel0, q) * vec4(length(q) - 0.5, .91, abs(q.y), 0.) * 0.99;
    }

    return (
        vec4(r - tan(time * 4.), r - q.y * 0.5, abs(p.y) * 2., 0.) * 0.75 + q.y * 0.5
    ) * abs(p.x * 1.);

    // return vec4(r - tan(time * 50.), r * (1. - q.y) * 7., abs(p.y) * 1.5, 0.).rgbb;// * 1.5;// - texture(channel2, q * 10. + time * 25.) - p.y * 0.5;
}
