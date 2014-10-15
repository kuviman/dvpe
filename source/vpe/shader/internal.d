module vpe.shader.internal;

import vpe.internal;

RawPolygon quadPoly;
RawShader basicVertexShader;

Shader colorShader, textureShader, circleShader;

void initShaders() {
	quadPoly = new RawPolygon(vec2(0, 0), vec2(1, 0), vec2(1, 1), vec2(0, 1));
	basicVertexShader = new RawShader(GL_VERTEX_SHADER, import("shader/vertex/basic.glsl"));
	colorShader = new Shader(import("shader/fragment/color.glsl"));
	textureShader = new Shader(import("shader/fragment/texture.glsl"));
	circleShader = new Shader(import("shader/fragment/circle.glsl"));
}

void renderPoly(Shader shader, RawPolygon polygon) {
	glUseProgram(shader.program);
	renderState.apply(shader);
	polygon.render(shader.program);
	shader.numTex = 0;
}
