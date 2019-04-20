float box(vec2 p, vec2 b) {
    return length(max(abs(p) - b, 0.)) - 0.01;
}

float rohtie(vec2 p) {
    p.x += 0.4;
    p.y -= 0.25;
    p /= 0.35;

    float r = 420.;

    // R
    r = min(r, box(p - vec2(0., 0.), vec2(0.05, 0.25)));
    r = min(r, length(p - vec2(0.2, 0.15)) - 0.1);

    // O
    r = min(r, max(-(length(p - vec2(0.4, -0.1)) - 0.025), length(p - vec2(0.4, -0.1)) - 0.15));

    // H
    r = min(r, box(p - vec2(0.5, 0.3), vec2(0.05, 0.2)));
    r = min(r, box(p - vec2(0.7, 0.0), vec2(0.05, 0.3)));
    r = min(r, box(p - vec2(0.6, 0.25), vec2(0.1, 0.05)));

    // T
    r = min(r, box(p - vec2(0.95, 0.0), vec2(0.05, 0.3)));
    r = min(r, box(p - vec2(0.95, 0.15), vec2(0.15, 0.05)));

    // I
    r = min(r, box(p - vec2(1.2, -0.2), vec2(0.05, 0.3)));
    r = min(r, length(p - vec2(1.2, 0.25)) - 0.075);

    // E
    r = min(r, max(-p.y, length(p - vec2(1.545, 0.)) - 0.25));
    r = min(r, box(p - vec2(1.355, -0.1), vec2(0.05, 0.1)));
    r = min(r, box(p - vec2(1.65, -0.15), vec2(0.25, 0.05)));

    // +
    r = min(r, box(p - vec2(2.8, -0.15), vec2(0.05, 0.3)));
    r = min(r, box(p - vec2(2.8, -0.15), vec2(0.3, 0.05)));

    return r;
}

float dawgphaze(vec2 p) {
    p.x += 0.81;
    p.y += 0.05;
    p /= 0.35;

    float r = 420.;

    // D
    r = min(r, max(-p.x - .05, length(p - vec2(-0.05, 0.)) - 0.5));

    // A
    r = min(r, box(p - vec2(0.55, -0.15), vec2(0.05, 0.3)));
    r = min(r, box(p - vec2(0.75, -0.15), vec2(0.05, 0.3)));
    r = min(r, box(p - vec2(0.65, -0.15), vec2(0.15, 0.05)));
    r = min(r, box(p - vec2(0.65, 0.15), vec2(0.15, 0.05)));

    // W
    r = min(r, box(p - vec2(.9, 0.), vec2(0.05, 0.3)));
    r = min(r, box(p - vec2(1.1, 0.), vec2(0.05, 0.3)));
    r = min(r, box(p - vec2(1.1, -0.2), vec2(0.2, 0.1)));
    r = min(r, box(p - vec2(1.3, 0.), vec2(0.05, 0.3)));

    // G
    r = min(r, box(p - vec2(1.45, 0.1), vec2(0.05, 0.2)));
    r = min(r, box(p - vec2(1.65, -0.1), vec2(0.05, 0.4)));
    r = min(r, box(p - vec2(1.55, -0.15), vec2(0.15, 0.05)));
    r = min(r, box(p - vec2(1.55, 0.3), vec2(0.15, 0.05)));
    r = min(r, box(p - vec2(1.45, -0.4), vec2(0.15, 0.1)));


    // P
    r = min(r, max(-p.x + 1.9, length(p - vec2(1.9, -0.2)) - 0.5));
    r = min(r, box(p - vec2(2.015, -0.8), vec2(0.1, 0.3)));

    // H
    r = min(r, box(p - vec2(2.5, -0.4), vec2(0.05, 0.5)));
    r = min(r, box(p - vec2(2.7, -0.3), vec2(0.05, 0.3)));
    r = min(r, box(p - vec2(2.6, -0.35), vec2(0.1, 0.05)));

    // A
    r = min(r, box(p - vec2(2.55 + 0.3, -0.05), vec2(0.05, 0.25)));
    r = min(r, box(p - vec2(2.75 + 0.3, -0.05), vec2(0.05, 0.25)));
    r = min(r, box(p - vec2(2.65 + 0.3, -0.15), vec2(0.15, 0.05)));
    r = min(r, box(p - vec2(2.65 + 0.3,  0.15), vec2(0.15, 0.05)));

    // Z
    r = min(r, box(p - vec2(3.4, -0.05), vec2(0.3, 0.05)));
    r = min(r, box((p - vec2(3.075, -0.55)) * rotate(-acos(-1.) * .275), vec2(.75, 0.05)));
    r = min(r, box(p - vec2(3.425, -1.05), vec2(.95, 0.05)));

    // E
    r = min(r, box(p - vec2(3.9, -0.4), vec2(0.05, 0.4)));
    r = min(r, box(p - vec2(4.05, -0.05), vec2(0.2, 0.05)));
    r = min(r, box(p - vec2(3.9, -0.35), vec2(0.2, 0.05)));
    r = min(r, box(p - vec2(4.1, -0.75), vec2(0.2, 0.05)));


    return r;
}

// BlackPurpl€ $BlackPurpl£ 2
float black(vec2 p) {
    p.x += 1.15;
    p.y += -0.25;
    p /= 0.35;

    float r = 420.0;

    // B
    r = min(r, max(-p.x + 1.9, length(p - vec2(1.9, -0.2)) - 0.5));
    r = min(r, max(-p.x + 1.9, length(p - vec2(1.9, -1.2)) - 0.5));
    r = min(r, box(p - vec2(2.015, -0.8), vec2(0.1, 0.3)));

    // L
    r = min(r, box(p - vec2(2.5, -0.6), vec2(0.05, 0.3)));
    r = min(r, box(p - vec2(2.6, -0.85), vec2(0.1, 0.05)));

    // A
    r = min(r, box(p - vec2(3.4, -0.25), vec2(0.3, 0.05)));
    r = min(r, box((p - vec2(3.075, -0.75)) * rotate(-acos(-1.) * .275), vec2(.75, 0.05)));
    r = min(r, box(p - vec2(3.65, -0.7), vec2(0.05, .5)));

    // C
    r = min(r, box(p - vec2(3.85, -0.7), vec2(0.05, .5)));
    r = min(r, box(p - vec2(4.0, -0.25), vec2(0.1, 0.05)));
    r = min(r, box(p - vec2(4.0, -1.15), vec2(0.1, 0.05)));
    r = min(r, box(p - vec2(4.05, -1.05), vec2(0.05, 0.05)));
    r = min(r, box(p - vec2(4.05, -0.35), vec2(0.05, 0.05)));

    // K
    r = min(r, box(p - vec2(4.25, -0.7), vec2(0.05, .95)));
    r = min(r, box((p - vec2(4.4, -0.75)) * rotate(-acos(-1.) * .275), vec2(.2, 0.05)));
    r = min(r, box((p - vec2(4.6, -1.)) * rotate(-acos(-1.) * -.2), vec2(.3, 0.05)));

    return r;
}

// €
float euro(vec2 p) {
    p.x += 1.15;
    p.y += -0.2;

    p /= 0.35;

    float r = 420.0;

    r = max(p.x - 4.45, length(p - vec2(4.45, -0.2)) - 0.5);
    r = max(r, -(r + 0.15));
    r = max(r, -box(p - vec2(4.6, -0.2), vec2(0.35, 0.2)));
    r = min(r, box(p - vec2(4.05, -0.15), vec2(0.2, 0.05)));
    r = min(r, box(p - vec2(4.05, -0.0), vec2(0.2, 0.05)));

    return r;
}

// £
float gbp(vec2 p) {
    p.x += 1.15;
    p.y += -0.15;

    p /= 0.35;

    float r = 420.0;

    r = max(p.x - 4.65, length(p - vec2(4.65, -0.2)) - 0.5);
    r = max(r, -(r + 0.125));
    r = max(r, -box(p - vec2(4.8, -0.2), vec2(0.35, 0.2)));
    r = max(r, -p.y - 0.2);
    r = min(r, box(p - vec2(4.25, -0.15), vec2(0.2, 0.05)));
    r = min(r, box(p - vec2(4.23, -0.3), vec2(0.05, 0.2)));
    r = min(r, box(p - vec2(4.35, -0.5), vec2(0.3, 0.05)));

    return r;
}

// Purpl
float purpl(vec2 p) {
    p.x += 1.15;
    p.y += -0.2;
    p /= 0.35;

    float r = 420.0;

    // P
    r = min(r, max(-p.x + 1.9, length(p - vec2(1.9, -0.2)) - 0.5));
    r = min(r, box(p - vec2(2.015, -0.8), vec2(0.1, 0.3)));

    // U
    r = min(r, box(p - vec2(2.5, -0.7), vec2(0.05, 0.4)));
    r = min(r, box(p - vec2(2.6, -1.05), vec2(0.1, 0.05)));
    r = min(r, box(p - vec2(2.7, -0.7), vec2(0.05, 0.4)));

    // R
    r = min(r, box(p - vec2(2.9, -0.85), vec2(0.05, 0.55)));
    r = min(r, box((p - vec2(3.1, -1.)) * rotate(-acos(-1.) * -.2), vec2(.5, 0.05)));
    r = min(r, box(p - vec2(3.05, -0.35), vec2(0.2, 0.05)));
    r = min(r, box(p - vec2(3.05, -0.75), vec2(0.2, 0.05)));
    r = min(r, box(p - vec2(3.2, -0.55), vec2(0.05, 0.15)));

    // P
    r = min(r, box(p - vec2(3.4, -0.65), vec2(0.05, 0.55)));
    r = min(r, box(p - vec2(3.55, -0.35), vec2(0.2, 0.05)));
    r = min(r, box(p - vec2(3.55, -0.75), vec2(0.2, 0.05)));
    r = min(r, box(p - vec2(3.7, -0.55), vec2(0.05, 0.15)));

    // L
    r = min(r, box(p - vec2(3.9, -0.6), vec2(0.05, 0.3)));
    r = min(r, box(p - vec2(4.15, -0.85), vec2(0.2, 0.05)));

    return r;
}

vec4 pixel(vec2 p) {
    p /= resolution;
    vec2 q = p;
    p -= .5;
    p.x *= resolution.x / resolution.y;

    float text = 420.0;


    if (time > 192.0) {
        text = dawgphaze(p - vec2(0.02, 0.16));

      if (text > 0.0) {
          // IN
          q *= 1.02;
          q -= 0.01;

          return 0.01 + texture(channel0, q) * vec4(.7 + mod(-time, 1.) * .2, .5  + mod(time * 4., 1.) * .6, .2, 0.) * 1.1;
      }
    }
    else if (time > 35.0) {
      float black = black(p);
      float purpl = purpl(p);

      purpl = min(purpl, mix(euro(p), gbp(p), floor(mod(time * 1.0, 2.0))));

      float mixer = floor(mod(time * 2.0, 2.0));
      mixer = mix(mixer, sin(time * 8.) + 0.5, min(max((time - 100.0) * 2.0, 0.), 1.));

      text = mix(black, purpl, mixer);

      if (text > 0.0) {
          // IN
          q *= 1.01;
          q -= 0.005;

          return 0.01 + texture(channel0, q) * vec4(.7 + mod(-time, 1.) * .2, .5  + mod(time * 4., 1.) * .5, .8, 0.) * 1.25;
      }
    }
    else if (time > 35.0) {
      float black = black(p);
      float purpl = purpl(p);

      purpl = min(purpl, mix(euro(p), gbp(p), floor(mod(time * 1.0, 2.0))));

      float mixer = floor(mod(time * 2.0, 2.0));
      mixer = mix(mixer, sin(time * 8.) + 0.5, min(max((time - 100.0) * 2.0, 0.), 1.));

      text = mix(black, purpl, mixer);

      if (text > 0.0) {
          // IN
          q *= 1.01;
          q -= 0.005;

          return 0.01 + texture(channel0, q) * vec4(.7 + mod(-time, 1.) * .2, .5  + mod(time * 4., 1.) * .5, .8, 0.) * 1.25;
      }
    }
    else if (time > 19.0) {
      p.x += tan(p.y + time * .5 + 0.5 + cnoise(vec3(p * 2.5, time * 0.15))) * .01;
      p.x += sin(p.x * 2. + time) * .2;

      p.y += tan(sin(p.x * .5) * .05 + time + 1.3) * .02;

      text = rohtie(p);
      text = min(text, dawgphaze(p));

      if (text > 0.0) {
          // OUT
          q /= 1.01;
          q += 0.005;

          return texture(channel0, q) * vec4(1.01, 1.01, 1.0, 0.) * .97;
      }
    }
    else {
      p.x += tan(p.y + time * .5 + 0.5 + cnoise(vec3(p * 2.5, time * 0.15))) * .01;
      p.x += sin(p.x * 2. + time) * .2;

      float correction = (1.0 - min(max((time - 10.0) * .5, 0.), 1.));

      text = rohtie(p);
      text = min(text, dawgphaze(p));
      text = max(text, -p.y - time + 3.15 + sin(p.x * 20.) * .2) * correction;

      text += sin(p.y * 20. + time * 4.) * .01;


      if (text < 0.0) {
          // IN
          q *= 1.01;
          q -= 0.005;

          q.x += sin(q.y * 10. + time * 2.) * correction;

          return 0.01 + texture(channel0, q) * vec4(.7, .5, .8, 0.) * 1.19;
      }
    }

    p += cnoise(vec3(p * 0.8, 1.5 + time * 0.012));
    p += cnoise(vec3(p * 2.99, -13.15));
    p += tan(p.x * 0.8);
    p += hash(p) * .05;

    float r = cnoise(vec3(p * 70., time * .75));
    r += hash(p) * p.y;
    r /= p.x;

    // EXPLODE
    float explodeTime = max((time - 19.0), 0.);
    r += tan(min(explodeTime * 1.25, 20.) * explodeTime);

    return vec4(r + p.x * .01 + mod(p.y * 2., 0.7) * sin(time * (0.2 + tan(time * .02))) * 1.5, r - abs(p.x * 0.25) * 1.2, r - (1. - q.y) * .25, 0.);

}
