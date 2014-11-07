module vpe.shader.internal;

import vpe.internal;

RawPolygon quadPoly;
RawShader basicVertexShader;

Shader colorShader, textureShader, circleShader, dashedShader;

version(OpenGL2)
	enum gl2 = "gl2_";
else
	enum gl2 = "";

void initShaders() {
	quadPoly = new RawPolygon(vec2(0, 0), vec2(1, 0), vec2(1, 1), vec2(0, 1));
	basicVertexShader = new RawShader(GL_VERTEX_SHADER, import(gl2~"shader_vertex_basic.glsl"));
	colorShader = new Shader(import(gl2~"shader_color.glsl"));
	textureShader = new Shader(import(gl2~"shader_texture.glsl"));
	circleShader = new Shader(import(gl2~"shader_circle.glsl"));
	dashedShader = new Shader(import(gl2~"shader_dashed.glsl"));
}

void renderPoly(Shader shader, RawPolygon polygon) {
	glUseProgram(shader.program);
	renderState.apply(shader);
	polygon.render(shader.program);
	shader.numTex = 0;
}
