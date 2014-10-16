#version 150

uniform vec4 color;

out vec4 fragColor;
uniform float gap, period;
in vec3 modelPos;

void main() {
	float x = mod(modelPos.x, period);
	if (x < gap) discard;
	fragColor = color;
}
