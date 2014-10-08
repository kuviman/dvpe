module vpe.rawgl.texture;

import vpe.rawgl;

class Texture {
	this() {
		glGenTextures(1, &id);
		log("Creating texture (id = %s)", id);
	}
	~this() {
		if (vpeTerminated) return;
		freeQ.push(id);
	}
	alias id this;
	GLuint id;
}

private auto freeQ = new shared GLQueue();
void freeTextures() {
	GLuint id;
	while (freeQ.pop(id)) {
		log("Deleting texture (id = %s)", id);
		glDeleteTextures(1, &id);
	}
}
