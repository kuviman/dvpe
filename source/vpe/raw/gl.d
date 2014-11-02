module vpe.raw.gl;

import vpe.internal;

template aliasPlain(names...) {
	static if (names.length > 0) {
		mixin(`alias gl.` ~ names[0] ~ " " ~ names[0] ~ ";");
		mixin aliasPlain!(names[1..$]);
	}
}

mixin aliasPlain!(
	"GLenum",
	"GLuint",
	"GLint",
	"GL_TRUE",
	"GL_FALSE",
	"GL_SCISSOR_TEST",
	"GL_BLEND",
	"GL_SRC_ALPHA",
	"GL_ONE_MINUS_SRC_ALPHA",
	"GL_FRAMEBUFFER",
	"GL_RENDERBUFFER",
	"GL_TEXTURE_2D",
	"GL_DEPTH_ATTACHMENT",
	"GL_COLOR_ATTACHMENT0",
	"GL_DEPTH_COMPONENT",
	"GL_FRAMEBUFFER_COMPLETE",
	"GL_COLOR_BUFFER_BIT",
	"GL_DEPTH_BUFFER_BIT",
	"GL_DEPTH_TEST",
	"GLfloat",
	"GL_ARRAY_BUFFER",
	"GL_STATIC_DRAW",
	"GL_FLOAT",
	"GL_TRIANGLE_FAN",
	"GLsizei",
	"GL_LINK_STATUS",
	"GL_INFO_LOG_LENGTH",
	"GLchar",
	"GL_VERTEX_SHADER",
	"GL_FRAGMENT_SHADER",
	"GL_COMPILE_STATUS",
	"GL_LINEAR",
	"GL_NEAREST",
	"GL_TEXTURE0",
	"GL_RGBA",
	"GL_BGRA",
	"GL_UNSIGNED_BYTE",
	"GL_TEXTURE_MIN_FILTER",
	"GL_TEXTURE_MAG_FILTER",
	"GL_NO_ERROR"
);

private bool inBeginEnd = false;
template func(string name) {
	mixin("alias gl." ~ name ~ " f;");
	alias ParameterTypeTuple!f ArgTypes;
	alias ReturnType!f R;
	R func(string file = __FILE__, size_t line = __LINE__)(ArgTypes args) {
		static if (!is(R == void))
			R res = f(args);
		else
			f(args);
		static if (name == "glBegin")
			inBeginEnd = true;
		static if (name == "glEnd")
			inBeginEnd = false;
		if (!inBeginEnd) {
			auto error = gl.glGetError();
			if (error != GL_NO_ERROR)
				throw new Exception(
					"GL Error " ~ error.to!string ~
					" while calling " ~ name ~
					" from " ~ file ~ " : " ~ line.to!string);
		}
		static if (!is(R == void))
			return res;
	}
}

template aliasFunctions(names...) {
	static if (names.length > 0) {
		mixin(`alias func!"` ~ names[0] ~ `"` ~ names[0] ~ ";");
		mixin aliasFunctions!(names[1..$]);
	}
}

mixin aliasFunctions!(
	"glEnable",
	"glViewport",
	"glScissor",
	"glGenFramebuffers",
	"glBindFramebuffer",
	"glGenRenderbuffers",
	"glBindRenderbuffer",
	"glRenderbufferStorage",
	"glFramebufferRenderbuffer",
	"glFramebufferTexture2D",
	"glCheckFramebufferStatus",
	"glDeleteFramebuffers",
	"glDeleteRenderbuffers",
	"glClear",
	"glBlendFunc",
	"glClearColor",
	"glDisable",
	"glGenVertexArrays",
	"glBindVertexArray",
	"glGenBuffers",
	"glBindBuffer",
	"glBufferData",
	"glVertexAttribPointer",
	"glEnableVertexAttribArray",
	"glGetAttribLocation",
	"glDrawArrays",
	"glDeleteVertexArrays",
	"glDeleteBuffers",
	"glCreateProgram",
	"glDeleteProgram",
	"glAttachShader",
	"glLinkProgram",
	"glGetProgramiv",
	"glGetProgramInfoLog",
	"glCreateShader",
	"glDeleteShader",
	"glShaderSource",
	"glCompileShader",
	"glGetShaderiv",
	"glGetShaderInfoLog",
	"glGenTextures",
	"glDeleteTextures",
	"glUseProgram",
	"glGetUniformLocation",
	"glUniform1fv",
	"glUniform4fv",
	"glUniformMatrix4fv",
	"glUniformMatrix3fv",
	"glActiveTexture",
	"glBindTexture",
	"glUniform1i",
	"glTexImage2D",
	"glTexParameteri"
);

version (OpenGL2) {
	mixin aliasFunctions!(
		"glBegin",
		"glEnd",
		"glVertex3f"
	);
}
