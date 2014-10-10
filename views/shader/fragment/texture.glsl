#version 150

uniform vec4 color;
out vec4 fragColor;
in vec3 modelPos;

uniform sampler2D tex;

void main() {
	fragColor = texture(tex, modelPos.xy) * color;
}
