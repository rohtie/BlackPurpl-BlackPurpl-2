
float thingy(vec3 p) {
  p.x *= 0.45;

  p.xz *= rotate(p.y + time * .1);

  p += sin(p.yzx * 5. + time * 5.) * .5;
  p += sin(p.yzx * 20.) * .07;

  float r = length(p) - 1.25 + max((time - 67.) * .5, 0.);
  return r * 2.1;
}

float map(vec3 p) {
  float r = thingy(p);

  p.y += sin(p.x * .2 + time * .8) * .5;
  p.y += 0.5 + sin(p.z * .2 + time * .8) * .2;

  return smin(r, p.y + 0.5, 1.5);
}

vec4 pixel(vec2 p) {
  p /= resolution;

  vec2 q = p;

  p -= 0.5;
  p.x *= resolution.x / resolution.y;

  vec3 ray = vec3(p, -1.);
  vec3 cam = vec3(-0.65, 0., 5.);

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
                  return (texture(channel0, q)) * vec4(1.1, 0.5 + hash(p.xz), 1.0, 0.);
              }

              res = min(res, tmp/dist * 1.);
          }

          return vec4(res) * vec4(1. - p.y, 1.0 + hash(p.xz) * .4, 1. - abs(p.z * .45) * .2, 0.);
      }

      dist += tmp;

      if (dist > 20) {
          break;
      }
  }

  q.y -= 0.001;

  return texture(channel0, q) * vec4(1.01, 1.0 + sin(time * 5.2) * .01, 0.95, 0.);
}
