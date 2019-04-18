
float thingy(vec3 p) {
  p.x *= 0.45;
  // p.y += sin(time * .8);

  p.xz *= rotate(p.y + time * .1);

  p += sin(p.yzx * 5. + time * 5.) * .5;
  p += sin(p.yzx * 20.) * .07;

  float r = length(p) - 1.25 + max((time - 67.) * .5, 0.);
  return r * 2.1;
}

float sphereField(vec3 p) {
  float rep = 0.1;
  p = mod(p, rep);
  p -= rep * .75;

  float r = length(p) - .005;
  return r;
}

float map(vec3 p) {


  float vomitTime = clamp((time - 160.) * .8, 0., 1.);

  p.xz *= rotate(acos(-1.) * 1.5 + sin(time * 55.) * .01);
  p.zy *= rotate(acos(-1.) * 0.5 - vomitTime);

  p.x = abs(p.x);

  float r = 1000.;

  // Head base
  r = min(r, length((p - vec3(0., 1., 0.))  * vec3(.3, 0.35, 1.)) - .3);

  // Body
  r = min(r, length((p - vec3(0., -2.7, -1.)) * vec3(.25, 0.5, 1.)) - .5);
  r = smin(r, max(sphereField(p), r - .5), 0.6);
  r = smin(r, length(p - vec3(0., -.75, 0.2)) - 1., 0.5);

  // EYEBROWS
  r = min(r, (length((p - vec3(0.5, -0.3 + p.x * sin(time * .5) * .2, 1.0)) * vec3(.2, 1.5, 1.)) - .15));

  // Eyes
  r = smin(r, (length((p - vec3(.6, -.92 + p.x * .3, 1.05)) * vec3(1., .9, 1.)) - .25 - sin(time * 15.) * vomitTime * .01), 0.2);
  r = max(r, -(length((p - vec3(.6, -.98 + p.x * .37, 1.05)) * vec3(1., 1.1, 1.)) - .26));
  r = smin(r, (length((p - vec3(.6, -.98 + p.x * .37, 1.0)) * vec3(1., 1.1, 1.)) - .21), 0.1);

  // Nose
  r = smin(r, (length((p - vec3(0., -0.8, 1.15 - p.y * .2)) * vec3(1.1, .6, 1.)) - .05), 0.4);
  r = smin(r, (length((p - vec3(0.2, -1.0, 1.2)) * vec3(1., 1.2, 1.)) - .1), 0.1);
  r = max(r, -(length((p - vec3(0.12, -1.1, 1.2)) * vec3(1.8, 1., 1.)) - .1));

  // Chin
  r = smin(r, (length((p - vec3(0., -1.5, .3 - p.y * .2)) * vec3(.8, .6, 1.)) - .3), 0.25);

  // Mouth
  r = max(r, -(length((p - vec3(0.1, -1.4 - p.x * .3, 1.)) * vec3(.9, 1., 1.)) - .2));
  r = smin(r, (length((p - vec3(0.0, -1.45 + p.x * .3 + sin(p.z * 8. + time * 7.) * .03 - p.z * .12, 1.)) * vec3(1.6, 4., 1.)) - .2), 0.2 + (1. - vomitTime));

  return r;
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
          vec3 light = vec3(10., 5., 5.);
          cam = p;
          ray = normalize(light);

          float res = 1.;
          dist = 1.;

          for (int j=0; j<10; j++) {
              p = cam + ray * dist;

              float tmp = map(p);

              if (tmp < 0.001) {
                  res = 0.02;
                  // return (texture(channel0, q)) * vec4(1.1, 0.5 + hash(p.xz), 1.0, 0.);
                  break;
              }

              res = min(res, tmp/dist * 1.);
          }

          return vec4(res) * vec4(1. - p.y, 1.5 + hash(p.xz) * .4, 1.2 - abs(p.z * .45) * .2, 0.).gbra;
      }

      dist += tmp;

      if (dist > 20) {
          break;
      }
  }

  q.x -= 0.0001 + p.x * .002;
  q.y -= 0.0001 + p.y * .002;

  return texture(channel0, q) * vec4(1.01, 1.0 + sin(time * 5.2) * .01, 0.95, 0.).bgrr *  (1. - clamp((time - 178.) * .05, 0., 1.0));
}
