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
