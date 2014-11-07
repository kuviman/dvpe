#version 150

uniform vec4 color;

uniform float gap, period;
in vec3 modelPos;

out vec4 fragColor;

void main() {
	float x = mod(modelPos.x, period);
	if (x < gap) discard;
	fragColor = color;
}
