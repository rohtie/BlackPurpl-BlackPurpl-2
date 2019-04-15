
float screen(vec3 p) {
  p.x = abs(p.x);

  return length(max(abs(p - vec3(1.15, 0., 0.)) - vec3(2.5, -2., 0.2) * .1, 0.)) - 0.5;
}

float head(vec3 p) {
  return length(max(abs(p - vec3(0., 0., -2.2)) - vec3(0.2, 0.5, 0.5) * 1.75, 0.)) - 1.75;
}

float bumps(vec3 p) {
  float rep = 0.6;
  p = mod(p, rep);
  p -= rep * .5;

  float r = length(p) - 0.01;
  return r * sin(time * 4.);
}

float map(vec3 p) {
  float r = p.y + 2.5 + sin(p.z * .4 + time * 5.5) * .1 + bumps(p);

  r = min(r, head(p));
  r = min(r, screen(p));

  return r;
}

vec4 pixel(vec2 p) {
  p /= resolution;
  vec2 q = p;
  p -= 0.5;
  p.x *= resolution.x / resolution.y;

  vec3 ray = vec3(p, -1.);
  vec3 cam = vec3(1.2, 0., 0.0 + (time - 85.));

  float dist = 0.;

  for (int i=0; i<75; i++) {
    vec3 p = cam + ray * dist;

    float tmp = map(p);

    if (tmp < 0.001) {
      if (tmp == screen(p)) {
        return texture(channel0, q);
      }

      if (tmp == head(p)) {
        return vec4(0.);
      }

      vec3 light = vec3(tan(time) * 10., 5., 5.);
      cam = p;
      ray = normalize(light);

      float res = 1.;
      dist = 1.;

      for (int j=0; j<10; j++) {
        p = cam + ray * dist;

        float tmp = map(p);

        if (tmp < 0.001) {
            res = 0.05;
            break;
        }

        res = min(res, tmp/dist * 1.);
      }

      return vec4(res);
    }

    dist += tmp;

    if (dist > 20) {
        break;
    }
  }

  return vec4(0.0);
}
