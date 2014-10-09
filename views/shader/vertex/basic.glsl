#version 150

in vec3 position;

uniform mat4 modelMatrix;

out vec3 modelPos, worldPos, screenPos;

void main() {
	modelPos = position;
	worldPos = (modelMatrix * vec4(position, 1)).xyz;
	screenPos = worldPos;

	gl_Position = vec4(screenPos, 1);
}
