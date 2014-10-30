#version 120

uniform vec4 color;

varying vec3 modelPos;

void main() {
	if (length(modelPos - vec3(0.5, 0.5, 0)) > 0.5)
		discard;
	gl_FragColor = color;
}
