module vpe.shader;

import vpe.internal;
import vpe.shader.internal;

class Shader {
	this(string code) {
		program = new RawProgram(basicVertexShader,
			new RawShader(GL_FRAGMENT_SHADER, code));
	}
	void renderQuad() { this.render(quadPoly); }

	void setVec4(string name, vec4 vec) {
		glUseProgram(program);
		GLint pos = glGetUniformLocation(program, name.toStringz);
		vector!(4, GLfloat) v = vec;
		glUniform4fv(pos, 1, cast(GLfloat*)&v);
	}
	void setColor(string name, Color color) {
		setVec4(name, color.vec);
	}

	void setMat4(string name, mat4 mat) {
		glUseProgram(program);
		GLint pos = glGetUniformLocation(program, name.toStringz);
		matrix!(4, 4, GLfloat) fmat = mat;
		glUniformMatrix4fv(pos, 1, true, cast(GLfloat*)&fmat);
	}

private:
	void render(RawPolygon polygon) {
		renderState.apply(this);
		glUseProgram(program);
		polygon.render(program);
	}
	RawProgram program;
}
