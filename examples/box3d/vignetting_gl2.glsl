#version 120

uniform vec4 color;
varying vec3 modelPos;

void main() {
	float len = length(modelPos - vec3(0.5, 0.5, 0));
	float k = pow(len * 2, 0.5);
	gl_FragColor = color * k;
}
