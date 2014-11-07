#version 120

uniform vec4 color;
varying vec3 modelPos;

uniform mat3 textureMatrix;
uniform sampler2D tex;

void main() {
	gl_FragColor = texture2D(tex, (textureMatrix * vec3(modelPos.xy, 1)).xy) * color;
}
