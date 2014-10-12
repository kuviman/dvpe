#version 150

uniform vec4 color;
out vec4 fragColor;
in vec3 modelPos;

uniform mat3 textureMatrix;
uniform sampler2D tex;

void main() {
	fragColor = texture(tex, (textureMatrix * vec3(modelPos.xy, 1)).xy) * color;
}
