module vpe.shader;

import vpe.internal;
import vpe.shader.internal;

class Shader {
	this(string code) {
		program = new RawProgram(basicVertexShader,
			new RawShader(GL_FRAGMENT_SHADER, code));
	}
	void renderQuad() { this.render(quadPoly); }
	alias renderQuad render;

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

	void setMat3(string name, mat3 mat) {
		glUseProgram(program);
		GLint pos = glGetUniformLocation(program, name.toStringz);
		matrix!(3, 3, GLfloat) fmat = mat;
		glUniformMatrix3fv(pos, 1, true, cast(GLfloat*)&fmat);
	}

	void setTexture(string name, Texture texture) {
		glUseProgram(program);
		GLint loc = glGetUniformLocation(program, name.toStringz);
		int id = numTex++;
		glActiveTexture(GL_TEXTURE0 + id);
		glBindTexture(GL_TEXTURE_2D, texture.getRawTexture);
		glUniform1i(loc, id);
	}

private:
	int numTex = 0;
	void render(RawPolygon polygon) {
		renderState.apply(this);
		glUseProgram(program);
		polygon.render(program);
		numTex = 0;
	}
	RawProgram program;
}
