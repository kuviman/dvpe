#version 120

attribute vec3 position;

uniform mat4 modelMatrix, projectionMatrix;

varying vec3 modelPos, worldPos, screenPos;

void main() {
	modelPos = position;
	worldPos = (modelMatrix * vec4(modelPos, 1)).xyz;
	screenPos = (projectionMatrix * vec4(worldPos, 1)).xyz;

	gl_Position = vec4(screenPos, 1);
}
