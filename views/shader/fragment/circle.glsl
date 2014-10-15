#version 150

uniform vec4 color;

out vec4 fragColor;

in vec3 modelPos;

void main() {
	if (length(modelPos - vec3(0.5, 0.5, 0)) > 0.5)
		discard;
	fragColor = color;
}
