module vpe.raw;

public {
	import vpe.raw.shader;
	import vpe.raw.program;
	import vpe.raw.polygon;
	import vpe.raw.texture;

	import vpe.internal;
}

synchronized class GLQueue {
	void push(GLuint val) {
		buf[t] = val;
		t = (t + 1) % buf.length;
	}
	bool pop(ref GLuint val) {
		if (h == t) return false;
		val = buf[h];
		h = (h + 1) % buf.length;
		return true;
	}
private:
	size_t h = 0, t = 0;
	GLuint buf[10500];
}

void freeResources() {
	freeShaders();
	freePrograms();
	freeTextures();
	freePolygons();
}
