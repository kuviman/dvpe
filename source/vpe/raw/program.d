module vpe.raw.program;

import vpe.internal;

class RawProgram {
	this(RawShader[] shaders...) {
		this.shaders = shaders.dup;
		id = glCreateProgram();
		log("Creating program (id = %s)", id);
		scope(failure) glDeleteProgram(id);
		foreach (shader; shaders)
			glAttachShader(id, shader);
		glLinkProgram(id);
		GLint status;
		glGetProgramiv(id, GL_LINK_STATUS, &status);
		if (status == 0) {
			GLsizei len;
			glGetProgramiv(id, GL_INFO_LOG_LENGTH, &len);
			GLchar[] log = new GLchar[len];
			glGetProgramInfoLog(id, len, null, log.ptr);
			throw new Exception(log.to!string);
		}
	}
	RawShader[] shaders;
	~this() {
		if (vpeTerminated) return;
		freeQ.push(id);
	}
	alias id this;
	GLuint id;
}

private auto freeQ = new shared GLQueue();
void freePrograms() {
	GLuint id;
	while (freeQ.pop(id)) {
		log("Deleting program (id = %s)", id);
		glDeleteProgram(id);
	}
}
