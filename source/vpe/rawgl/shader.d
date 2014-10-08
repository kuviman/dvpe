module vpe.rawgl.shader;

import vpe.rawgl;

class Shader {
	this(GLenum type, string text) {
		id = glCreateShader(type);
		log("Creating shader (id = %s)", id);
		scope(failure) glDeleteShader(id);
		GLint srclen = to!GLint(text.length);
		auto ptr = text.ptr;
		glShaderSource(id, 1, &ptr, &srclen);
		glCompileShader(id);
		GLint status;
		glGetShaderiv(id, GL_COMPILE_STATUS, &status);
		if (status == GL_FALSE) {
			GLint len;
			glGetShaderiv(id, GL_INFO_LOG_LENGTH, &len);
			GLchar[] log = new GLchar[len];
			glGetShaderInfoLog(id, len, null, log.ptr);
			throw new Exception(log.to!string);
		}
	}
	~this() {
		if (vpeTerminated) return;
		freeQ.push(id);
	}
	alias id this;
	GLuint id;
}

private auto freeQ = new shared GLQueue();
void freeShaders() {
	GLuint id;
	while (freeQ.pop(id)) {
		log("Deleting shader (id = %s)", id);
		glDeleteShader(id);
	}
}
