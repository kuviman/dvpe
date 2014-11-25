#version 150

uniform vec4 color;
in vec3 modelPos;
out vec4 fragColor;

void main() {
	float len = length(modelPos - vec3(0.5, 0.5, 0));
	float k = pow(len, 0.5);
	fragColor = color * k;
}
