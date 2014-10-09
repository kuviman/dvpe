module vpe.shader;

import vpe.internal;
import vpe.shader.internal;

class Shader {
	this(string code) {
		program = new RawProgram(basicVertexShader,
			new RawShader(GL_FRAGMENT_SHADER, code));
	}
	void renderQuad() { this.render(quadPoly); }

private:
	void render(RawPolygon polygon) {
		glUseProgram(program);
		polygon.render(program);
	}
	RawProgram program;
}
