module vpe.raw;

public {
	import vpe.raw.shader;
	import vpe.raw.program;
	import vpe.raw.polygon;
	import vpe.raw.texture;
	import vpe.raw.ttf;

	import vpe.internal;
}

synchronized class SynQueue(T) {
	void push(T val) shared {
		buf[t] = cast(shared T) val;
		t = (t + 1) % buf.length;
	}
	bool pop(ref T val) shared {
		if (h == t) return false;
		val = cast(T) buf[h];
		h = (h + 1) % buf.length;
		return true;
	}
private:
	size_t h = 0, t = 0;
	T buf[10500];
}

void freeResources() {
	freeShaders();
	freePrograms();
	freeTextures();
	freePolygons();
	freeTTFs();
}
