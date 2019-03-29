// Park 007
// ch0: Grass
// ch1: Self
// ch2: Coral

float caps( vec3 p, vec3 a, vec3 b, float r ) {
    vec3 pa = p - a, ba = b - a;
    float h = clamp( dot(pa,ba)/dot(ba,ba), 0.0, 1.0 );
    return length( pa - ba*h ) - r;
}

float smin( float a, float b, float k ){
    float h = max( k-abs(a-b), 0.0 )/k;
    return min( a, b ) - h*h*h*k*(1.0/6.0);
}

mat2 rotate(float a) {
    return mat2(-sin(a), cos(a),
                 cos(a), sin(a));
}

float map(vec3 p) {
    p.y += 0.5;
    p.y += sin(p.x * 0.2 + time) * 0.6;
    p.y += sin(p.z * 0.1 + time * 0.2) * 0.5;

    p.y += 0.5;
    p.y += texture(channel2, p.xz * 0.0125 - time * 0.015).r * 0.9;
    return p.y * 0.275;
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

        if (tmp < 0.001) {
            return ((
                vec4(dist * 0.2, dist * 0.9, dist * 0.2, 0.)
                * texture(channel2, p.xz * 0.0125 - time * 0.015).r
                + vec4(p.z * 0.2, 0., -abs(sin(p.x) * 0.5), 0.)
            ) - p.z * 0.3) * 0.1 + vec4(p.z * 1., 0., abs(p.x), 0.) * 0.075;
        }

        if (dist > 30.) {
            break;
        }

        dist += tmp;
    }


    // p.y += texture(channel0, q * .05).r * 0.2;
    // p.x += time * 0.01;
    // q += time * 0.4;

    p.x += texture(channel0, q * .1 + time * 0.015).r * 0.6;
    // p.y += cos(time * 20.);
    // p.x = abs(p.x) + sin(time * 20.);
    // p.y = abs(p.y) - tan(time * 2.);
    p.x += texture(channel0, q * rotate(time * 0.15) - time * 0.15).r * 1.;


    // p += atan(p.x - tan(time * 5.), p.y + tan(time * 50.)) * 0.5;

    // if (int(mod(time, 5.)) == 0) {
    // }
    // p.x += sin(p.y * 20. * texture(channel0, vec2(0.2, 0.)).r + time * 5.) * .15;

    p.x += tan(p.x * 1. + texture(channel0, vec2(0.01, 0.)).r * 10. + time * 5.);
    // p.y += tan(p.x * 10.);
    p.x += sin(p.x * 23.5);
    p.x += sin(p.y * 9.65 + time * 20.) * .5;
    // p.y += tan(p.x * 20. + time * 20.) * 0.2;


    float r = length(max(abs(p) - 0.01 - texture(channel0, vec2(0.05, 0.)).r * .5, 0.)) - 0.01;

    if (r > 0.8) {
        q.y -= 0.001;
        return texture(channel1, q) * vec4(length(q) - 0.5, .91, abs(q.y), 0.) * 0.99;
    }

    return (
        vec4(r - tan(time * 2.), r - q.y * 0.5, abs(p.y) * 2., 0.) * 0.75 + q.y * 0.5
    ) * abs(p.x * 1.);

    // return vec4(r - tan(time * 50.), r * (1. - q.y) * 7., abs(p.y) * 1.5, 0.).rgbb;// * 1.5;// - texture(channel2, q * 10. + time * 25.) - p.y * 0.5;
}
