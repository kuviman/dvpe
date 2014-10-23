/**
 * Shaders
 *
 * Use this only if you need some custom shaders
 *
 * Copyright: © 2014 kuviman
 * License: MIT
 * Authors: kuviman
 */
module vpe.shader;

import vpe.internal;
import vpe.shader.internal;

/// Shader
class Shader {
	/// Compile code into a shader
	this(string code) {
		program = new RawProgram(basicVertexShader,
			new RawShader(GL_FRAGMENT_SHADER, code));
	}
	/// render a quad
	void renderQuad() { renderPoly(this, quadPoly); }
	/// ditto
	alias renderQuad render;

	/// set uniform
	void setFloat(string name, real val) {
		glUseProgram(program);
		GLint pos = glGetUniformLocation(program, name.toStringz);
		GLfloat v = val;
		glUniform1fv(pos, 1, &v);
	}
	/// ditto
	void setVec4(string name, vec4 vec) {
		glUseProgram(program);
		GLint pos = glGetUniformLocation(program, name.toStringz);
		vector!(4, GLfloat) v = vec;
		glUniform4fv(pos, 1, cast(GLfloat*)&v);
	}
	/// ditto
	void setColor(string name, Color color) {
		setVec4(name, color.vec);
	}

	/// ditto
	void setMat4(string name, mat4 mat) {
		glUseProgram(program);
		GLint pos = glGetUniformLocation(program, name.toStringz);
		matrix!(4, 4, GLfloat) fmat = mat;
		glUniformMatrix4fv(pos, 1, true, cast(GLfloat*)&fmat);
	}

	/// ditto
	void setMat3(string name, mat3 mat) {
		glUseProgram(program);
		GLint pos = glGetUniformLocation(program, name.toStringz);
		matrix!(3, 3, GLfloat) fmat = mat;
		glUniformMatrix3fv(pos, 1, true, cast(GLfloat*)&fmat);
	}

	/// ditto
	void setTexture(string name, Texture texture) {
		glUseProgram(program);
		GLint loc = glGetUniformLocation(program, name.toStringz);
		int id = numTex++;
		glActiveTexture(GL_TEXTURE0 + id);
		glBindTexture(GL_TEXTURE_2D, texture.getRawTexture);
		glUniform1i(loc, id);
	}

package:
	int numTex = 0;
	RawProgram program;
}
