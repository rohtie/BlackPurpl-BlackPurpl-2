vec4 pixel(vec2 p) {
    p /= resolution;
    p -= 0.5;

    p.x *= resolution.x / resolution.y;
    p.y += sin(p.x * 5.0 + time);

    float r = length(mod(p, 0.2)) -0.2;
    r = smoothstep(0., 0.001, r);

    return vec4(0.,0.,r,0.).brgr;
}

// //
// // SERENDIP banner
// //

// // channel0 -> RGB noise
// // channel1 -> Self
// // channel2 -> Stone


// float caps( vec3 p, vec3 a, vec3 b, float r ) {
//     vec3 pa = p - a, ba = b - a;
//     float h = clamp( dot(pa,ba)/dot(ba,ba), 0.0, 1.0 );
//     return length( pa - ba*h ) - r;
// }

// float smin( float a, float b, float k ){
//     float h = max( k-abs(a-b), 0.0 )/k;
//     return min( a, b ) - h*h*h*k*(1.0/6.0);
// }

// mat2 rotate(float a) {
//     return mat2(-sin(a), cos(a),
//                  cos(a), sin(a));
// }

// float map(vec3 p) {
//     // p.xz *= rotate(acos(-1.));
//     // p.xz *= rotate(time);

//     float bevel = texture(channel2, p.xz * vec2(1., 2.)).r * 0.25;

//     p.y += sin(p.x * 0.65 - time * 0.9);
//     // p.y += sin(p.x * 0.65 + 1.);

//     p.z = abs(p.z);

//     float r = caps(p, vec3(-2.5, 0., 0.), vec3(2.5, 0., 0.), 0.25 + abs(sin(-1.5 + p.x * 0.6)) * 0.6 - abs(p.y) * 0.5);

//     vec3 start = vec3(-1., 0.1, .5);
//     vec3 end = vec3(-0.25, 0. + sin(time * 0.9), 1.);

//     r = smin(r, caps(p, start, end, 0.2), 0.5);

//     r = smin(r, caps(p, vec3(2.5, 0., 0.), vec3(3., 0., 1.), 0.05), 1.);

//     r -= bevel;

//     return r * 0.7;
// }

// vec4 pixel(vec2 p) {
//     float time = time + 2500.0;

//     p /= resolution;
//     vec2 q = p;
//     p -= .5;
//     p.x *= resolution.x / resolution.y;


//     vec3 ray = vec3(p, -1.);
//     vec3 cam = vec3(0., 0., 5.);

//     float dist = 0.;

//     for (int i=0; i<100; i++) {
//         vec3 p = cam + ray * dist;

//         float tmp = map(p);

//         if (tmp < 0.001) {
//             // return vec4(dist * 0.05);
//             // return vec4(1.);
//             return (
//                 texture(channel2, p.xz * vec2(1., 2.) - time * 0.2)
//                 * vec4(0.6 - p.x + sin(p.y * 5.) * 0.3, 0.15, p.x * 0.6 + sin(p.y * 5.) * 0.3, 0.)
//             );
//         }

//         dist += tmp;
//     }



//     p.x += tan(p.y * 2.);

//     // p.y += texture(channel0, q * 1.).r * 0.1;
//     // p.y += texture(channel0, q * 1.).r * 5.;
//     p.y = abs(p.y) + sin(p.x + time);
//     p.x += p.y * 20.;

//     p.x += sin(p.y * 5. + time);
//     p.y += tan(p.y * 2. - time * 2.);
//     p.x += sin(p.y * 2. - tan(time * 10. * p.y * 15.));

//     float r = length(p) - 0.25 + sin(time * 50.);
//     r = 1. - r;

//     if (r < 0.5) {
//         q.x *= 0.99;
//         return texture(channel1, q).bgrr * 1.01 + vec4(p.x * 2., p.y * .05, 0.01, 0.).bgrr;
//     }

//     return texture(channel0, p).brgr * 30.;





//     // // p.y += texture(channel0, q * .05).r * 0.2;
//     // // p.x += texture(channel0, q * .10).r * 0.2;
//     // p.y += cos(time * 20.);
//     // // p.x = abs(p.x) + sin(time * 20.);
//     // // p.y = abs(p.y) - tan(time * 2.);


//     // p += atan(p.x - tan(time * 5.), p.y + tan(time * 50.)) * 0.5;

//     // // if (int(mod(time, 5.)) == 0) {
//     // // }
//     // p.x += sin(p.y * 20. * texture(channel0, vec2(0.2, 0.)).r + time * 5.) * .15;

//     // p.x += tan(p.x * 1. + texture(channel0, vec2(0.01, 0.)).r * 10. + time * 5.);
//     // p.y += tan(p.x * 10.);
//     // p.x += sin(p.x * 23.5);
//     // p.x += sin(p.y * 9.65 + time * 20.) * .5;
//     // p.y += tan(p.x * 20. + time * 20.) * 0.2;


//     // float r = length(max(abs(p) - 0.01 - texture(channel0, vec2(0.05, 0.)).r * .5, 0.)) - 0.01;
//     // // r = smoothstep(0., 0.5, r);

//     // if (r > 0.1) {
//     //     // q *= 0.99;
//     //     // q += 0.005;
//     //     // q.y += 0.01;

//     //     // return vec4(0.01, 0.1, 0.1, 0.) * 0.5;

//     //     // p = q;
//     //     // p -= 0.5;
//     //     // p.x *= resolution.x / resolution.y;

//     //     // float rep = 0.04;
//     //     // p = mod(p, rep);
//     //     // p -= rep * 0.5;

//     //     // float dots = length(p) - 0.0001;
//     //     // dots = smoothstep(0., 0.001, dots);
//     //     // dots = 1. - dots;
//     //     // dots *= 1. - length(q - 0.5) - 0.5;

//     //     return texture(channel1, q) * vec4(0.92, .91, .96, 0.) * 0.9;// + dots * vec4(1., 1., 0., 0.);
//     //     // return texture(channel1, q) * vec4(0.92, .91, .96, 0.);
//     // }

//     // // return vec4(r - tan(time * 50.), r - q.y * 0.5, abs(p.y) * 2., 0.).rgbb * 1.5 - texture(channel2, q * 10. + time * 25.) - p.y * 0.5;
//     // return vec4(r - tan(time * 50.), r * (1. - q.y) * 7., abs(p.y) * 1.5, 0.).rgbb;// * 1.5;// - texture(channel2, q * 10. + time * 25.) - p.y * 0.5;
// }
