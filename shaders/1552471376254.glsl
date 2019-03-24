
vec4 permute(vec4 x){return mod(((x*34.0)+1.0)*x, 289.0);}
vec4 taylorInvSqrt(vec4 r){return 1.79284291400159 - 0.85373472095314 * r;}
vec3 fade(vec3 t) {return t*t*t*(t*(t*6.0-15.0)+10.0);}

float cnoise(vec3 P){
  vec3 Pi0 = floor(P); // Integer part for indexing
  vec3 Pi1 = Pi0 + vec3(1.0); // Integer part + 1
  Pi0 = mod(Pi0, 289.0);
  Pi1 = mod(Pi1, 289.0);
  vec3 Pf0 = fract(P); // Fractional part for interpolation
  vec3 Pf1 = Pf0 - vec3(1.0); // Fractional part - 1.0
  vec4 ix = vec4(Pi0.x, Pi1.x, Pi0.x, Pi1.x);
  vec4 iy = vec4(Pi0.yy, Pi1.yy);
  vec4 iz0 = Pi0.zzzz;
  vec4 iz1 = Pi1.zzzz;

  vec4 ixy = permute(permute(ix) + iy);
  vec4 ixy0 = permute(ixy + iz0);
  vec4 ixy1 = permute(ixy + iz1);

  vec4 gx0 = ixy0 / 7.0;
  vec4 gy0 = fract(floor(gx0) / 7.0) - 0.5;
  gx0 = fract(gx0);
  vec4 gz0 = vec4(0.5) - abs(gx0) - abs(gy0);
  vec4 sz0 = step(gz0, vec4(0.0));
  gx0 -= sz0 * (step(0.0, gx0) - 0.5);
  gy0 -= sz0 * (step(0.0, gy0) - 0.5);

  vec4 gx1 = ixy1 / 7.0;
  vec4 gy1 = fract(floor(gx1) / 7.0) - 0.5;
  gx1 = fract(gx1);
  vec4 gz1 = vec4(0.5) - abs(gx1) - abs(gy1);
  vec4 sz1 = step(gz1, vec4(0.0));
  gx1 -= sz1 * (step(0.0, gx1) - 0.5);
  gy1 -= sz1 * (step(0.0, gy1) - 0.5);

  vec3 g000 = vec3(gx0.x,gy0.x,gz0.x);
  vec3 g100 = vec3(gx0.y,gy0.y,gz0.y);
  vec3 g010 = vec3(gx0.z,gy0.z,gz0.z);
  vec3 g110 = vec3(gx0.w,gy0.w,gz0.w);
  vec3 g001 = vec3(gx1.x,gy1.x,gz1.x);
  vec3 g101 = vec3(gx1.y,gy1.y,gz1.y);
  vec3 g011 = vec3(gx1.z,gy1.z,gz1.z);
  vec3 g111 = vec3(gx1.w,gy1.w,gz1.w);

  vec4 norm0 = taylorInvSqrt(vec4(dot(g000, g000), dot(g010, g010), dot(g100, g100), dot(g110, g110)));
  g000 *= norm0.x;
  g010 *= norm0.y;
  g100 *= norm0.z;
  g110 *= norm0.w;
  vec4 norm1 = taylorInvSqrt(vec4(dot(g001, g001), dot(g011, g011), dot(g101, g101), dot(g111, g111)));
  g001 *= norm1.x;
  g011 *= norm1.y;
  g101 *= norm1.z;
  g111 *= norm1.w;

  float n000 = dot(g000, Pf0);
  float n100 = dot(g100, vec3(Pf1.x, Pf0.yz));
  float n010 = dot(g010, vec3(Pf0.x, Pf1.y, Pf0.z));
  float n110 = dot(g110, vec3(Pf1.xy, Pf0.z));
  float n001 = dot(g001, vec3(Pf0.xy, Pf1.z));
  float n101 = dot(g101, vec3(Pf1.x, Pf0.y, Pf1.z));
  float n011 = dot(g011, vec3(Pf0.x, Pf1.yz));
  float n111 = dot(g111, Pf1);

  vec3 fade_xyz = fade(Pf0);
  vec4 n_z = mix(vec4(n000, n100, n010, n110), vec4(n001, n101, n011, n111), fade_xyz.z);
  vec2 n_yz = mix(n_z.xy, n_z.zw, fade_xyz.y);
  float n_xyz = mix(n_yz.x, n_yz.y, fade_xyz.x);
  return 2.2 * n_xyz;
}

float hash(float n) { return fract(sin(n) * 1e4); }
float hash(vec2 p) { return fract(1e4 * sin(17.0 * p.x + p.y * 0.1) * (0.1 + abs(sin(p.y * 13.0 + p.x)))); }

float smin( float a, float b, float k ) {
    float h = max( k-abs(a-b), 0.0 )/k;
    return min( a, b ) - h*h*k*(1.0/4.0);
}

mat2 rotate(float a) {
  return mat2(-sin(a), cos(a),
               cos(a), sin(a));
}

float thingy(vec3 p) {
  p.x *= 0.45;

  p.xz *= rotate(p.y + time * .1);

  p += sin(p.yzx * 5. + time * 5.) * .5;
  p += sin(p.yzx * 20.) * .07;
  // p += cos(p.yzx * 2.) * .2;

  float r = length(p) - 1.25 + max((time - 67.) * .5, 0.);
  return r * 2.1;
}

float map(vec3 p) {
  float r = thingy(p);

  // p.y += texture(channel1, p.xz * .02).r;
  // p.y += cnoise(p * 1.5) * .5;
  // p.y += cnoise(p) * .25;
  // p.y += hash(p.xz) * .1;

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
                  return (texture(channel0, q)) * vec4(p.x * .5, 0.5 + hash(p.xz), 1.0, 0.);
                  break;
              }

              res = min(res, tmp/dist * 1.);
          }

          return vec4(res) * vec4(1. - p.y, 1.0 + hash(p.xz) * .4, 1., 0.);
      }

      dist += tmp;

      if (dist > 20) {
          break;
      }
  }

  q.y -= 0.001;
  return texture(channel0, q) * vec4(1.01, 1.0 + sin(time * 5.2) * .01, 0.95, 0.);
}
