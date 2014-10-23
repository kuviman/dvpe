#version 120

uniform vec4 color;

uniform float gap, period;
varying vec3 modelPos;

void main() {
	float x = mod(modelPos.x, period);
	if (x < gap) discard;
	gl_FragColor = color;
}
