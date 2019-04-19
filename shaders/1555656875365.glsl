float snackTime = clamp((time - 180.) * .5, 0., 1.);
float snackTime2 = clamp((time - 185.) * .1, 0., 1.);

float caps(vec3 p,vec3 a,vec3 b,float r) {
    vec3 pa = p-a;
    vec3 ba = b-a;
    float h = clamp(dot(pa,ba)/dot(ba,ba),0.,1.);
    return length(pa-ba*h)-r;
}

float map(vec3 p) {
    p.x += time * 2.5;

    float rep = 10.;
    float px = floor(p.x / rep);
    float pz = floor(p.z / rep);

    p.z += tan(p.x * 100.) * snackTime2;

    p.y += px * 2.3 - .4;

    p = mod(p, rep);
    p -= rep * .5;

    float localTime = time + pz * px;

    p.y += sin(p.x * .65 - localTime * .9);

    float r = caps(p, vec3(-2.5, 0., 0.), vec3(2.5, 0., 0.), .25 + abs(sin(-1.5 + p.x * .6)) * .6 - abs(p.y) * .5);

    vec3 start = vec3(-1., .1, .5);
    vec3 end = vec3(-.25, 0. + sin(localTime * .9), 1.);

    r = smin(r, caps(p, start, end, .2), .5);
    r = smin(r, caps(p, vec3(2.5, 0., 0.), vec3(3., 0., 1.), .05), 1.);
    r -= texture(channel0, p.xz * vec2(1., 2.)).r * .25;

    return r * .7;
}

vec4 pixel(vec2 p) {
    float time = time + 2500.;

    p /= resolution;
    vec2 q = p;
    p -= .5;
    p.x *= resolution.x / resolution.y;


    vec3 ray = vec3(p, -1.);
    vec3 cam = vec3(0., 0., 5.);

    float dist = 0.;

    for (int i=0; i<27; i++) {
        vec3 p = cam + ray * dist;

        float tmp = map(p);

        if (tmp < .0001) {
            return vec4(abs(p.y) * .05, .2 + tan(time * 20.) * (1. - snackTime), .3 + p.x * .01, 0.);
        }

        dist += tmp;
    }

    p.x += tan(p.y * 3.5);

    p.y = abs(p.y) + sin(p.x * .5 + time);
    p.x += p.y * 2500.;

    p.x += sin(p.y * 5. + time);
    p.y += tan(p.y * 2. - time * 2.);
    p.x += sin(p.y * 2. - tan(time * 10. * p.y * 15.));

    float r = 1. - length(p) - .25 + sin(time * 50.);

    if (r < .5) {
        q.x *= .99;
        return texture(channel0, q).gbrr * .92 + vec4(p.x * 2., p.y * .05, .01, 0.).bgrr - texture(channel1, q);
    }

    return texture(channel0, p);
}
