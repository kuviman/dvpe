#version 150

uniform vec4 color;

in vec3 modelPos;
out vec4 fragColor;

void main() {
	if (length(modelPos - vec3(0.5, 0.5, 0)) > 0.5)
		discard;
	fragColor = color;
}
