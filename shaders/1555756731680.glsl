float disttime = min(1., max(0., (time - 193.) * .75));
float disttime2 = min(1., max(0., (time - 204.) * 3.));
float disttime3 = min(1., max(0., (time - 198.) * 3.));

float map(vec3 p) {
    p.z += -time * 5.75;

    p.y += sin(p.z * 2.) * .2;


    p.xy *= rotate(p.z * disttime2 * -.01 - 0.8 * disttime3);

    return 1. - max(abs(p.x), abs(p.y)) - 0.82 * disttime;
}

vec4 pixel(vec2 p) {
    p /= resolution;
    vec2 q = p;
    p -= .5;
    p.x *= resolution.x / resolution.y;


    vec3 ray = vec3(p, -1.);
    vec3 cam = vec3(0., 0., 5.);

    float dist = 0.;

    for (int i=0; i<75; i++) {
        vec3 p = cam + ray * dist;

        float tmp = map(p);

        if (tmp < 0.001) {
            vec3 light = vec3(tan(time) * 10., 5., 5.);
            cam = p;
            ray = normalize(light);

            float res = 1.;
            dist = 1.;

            for (int j=0; j<10; j++) {
                p = cam + ray * dist;

                float tmp = map(p);

                if (tmp < 0.001) {
                    res = 0.01;
                    break;
                }

                res = min(res, tmp/dist * 1.);
            }

            p.x += cnoise(p * 7.) * .5;

            return res * vec4(1., 1., 1., 0.) * cnoise(p * 10.) + texture(channel1, mod(p.zy - vec2(time * 5., time * 10.5), vec2(1.0, 0.7)));
        }

        dist += tmp;

        if (dist > 20) {
            break;
        }
    }

    return vec4(1.);

}
