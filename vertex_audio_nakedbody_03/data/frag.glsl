#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D fft;
uniform float time;

uniform vec2 texOffset;
varying vec4 vertColor;
varying vec4 vertTexCoord;
varying vec3 fPosition;
varying vec3 norm;

mat3 yuv2rgb = mat3(1.0, 0.0, 1.13983,
                    1.0, -0.39465, -0.58060,
                    1.0, 2.03211, 0.0);

mat3 rgb2yuv = mat3(0.2126, 0.7152, 0.0722,
                    -0.300, -0.33609, 0.43600,
                    0.615, -0.5586, -0.05639);

void main() {
  float t = 10.0 * time;
  float pct = 0.0;
  pct = distance(norm,vec3(1.0, 0.0, 0.0));
  float col = fract(pct);

  vec4 c = 1.0 - texture2D(fft, norm.xy);
  float diff = abs(norm.y - c.g);
  float bri = dot(norm, vec3(0.0, 1.0, 0.0));

  // float bri = sin(t + 50.0*dot(norm, vec3(0.0, 0.0, 1.0)));
  gl_FragColor = diff > 0.1 ? vec4(0.0, 0.0, 0.0, 1.0) : vec4(vec3(bri), 1.0);
}

// void main() {
//   // Map the screen position to a position in the fft texture image
//   vec2 posInImage = vec2(vertTexCoord.x, 0.0);
  
//   // A. Show as a "graph"
//   //vec4 c = 1.0 - texture2D(fft, posInImage);
//   //float diff = abs(vertTexCoord.y - c.r);
//   //gl_FragColor = diff > 0.01 ? vec4(0.0, 0.0, 0.0, 1.0) : vec4(1.0);

//   // B. Show as color
//   vec4 c = texture2D(fft, posInImage);
//   gl_FragColor = c;

// }

// void main() {
// 	vec2 uv = vertTexCoord.xy;
// 	vec4 c = vec4(norm, 1.0);
// 	gl_FragColor = vec4(1.0, 1.0, 1.0, 1.0);
// }

