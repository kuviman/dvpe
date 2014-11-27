module vpe.raw.texture;

import vpe.internal;

class RawTexture {
	this() {
		glGenTextures(1, &id);
		//log("Creating texture (id = %s)", id);
	}
	~this() {
		if (vpeTerminated || freed) return;
		freeQ.push(id);
	}
	void free() {
		freed = true;
		freeQ.push(id);
	}
	alias id this;
	GLuint id;
	bool freed = false;
}

private auto freeQ = new shared SynQueue!GLuint();
void freeTextures() {
	GLuint id;
	while (freeQ.pop(id)) {
		//log("Deleting texture (id = %s)", id);
		glDeleteTextures(1, &id);
	}
}
