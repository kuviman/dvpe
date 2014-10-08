module vpe.rawgl;

public {
	import vpe.rawgl.shader;
	import vpe.rawgl.program;
	import vpe.rawgl.polygon;
	import vpe.rawgl.texture;

	import vpe.internal;
}

synchronized class GLQueue {
	void push(GLuint val) {
		t = (t + 1) % buf.length;
		buf[t] = val;
	}
	bool pop(ref GLuint val) {
		if (h == t) return false;
		val = buf[h];
		h = (h + 1) % buf.length;
		return true;
	}
private:
	size_t h, t;
	GLuint buf[10500];
}

void freeResources() {
	freeShaders();
	freePrograms();
	freeTextures();
	freePolygons();
}
