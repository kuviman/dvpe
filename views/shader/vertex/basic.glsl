#version 150

in vec3 position;

out vec3 modelPos, worldPos, screenPos;

void main() {
	modelPos = position;
	worldPos = position;
	screenPos = position;

	gl_Position = vec4(screenPos, 1);
}
