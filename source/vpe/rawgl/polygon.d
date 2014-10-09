module vpe.rawgl.polygon;

import vpe.rawgl;

class RawPolygon {
	GLuint VAO, VBO;
	int cnt;

	this(vec2[] points...) {
		vec3[] p3;
		foreach (p; points)
			p3 ~= vec3(p.x, p.y, 0);
		this(p3);
	}
	this(vec3[] points...) {
		glGenVertexArrays(1, &VAO);
		log("Creating VAO (id = %s)", VAO);
		glBindVertexArray(VAO);
		glGenBuffers(1, &VBO);
		log("Creating VBO (id = %s)", VBO);
		glBindBuffer(GL_ARRAY_BUFFER, VBO);
		GLfloat[] mesh = new GLfloat[points.length * 3];
		foreach(i, p; points) {
			foreach (j; RangeTuple!3)
				mesh[i * 3 + j] = p[j];
		}
		cnt = cast(int)points.length;
		glBufferData(GL_ARRAY_BUFFER, cnt * 3 * GLfloat.sizeof, mesh.ptr, GL_STATIC_DRAW);
	}

	void initAttr(GLint loc) {
		if (loc == -1) return;
		glVertexAttribPointer(loc, 3, GL_FLOAT, GL_FALSE, GLfloat.sizeof * 3, null);
		glEnableVertexAttribArray(loc);
	}

	void render(RawProgram program) {
		glBindVertexArray(VAO);
		GLint posLoc = glGetAttribLocation(program, "position");
		initAttr(posLoc);
		glDrawArrays(GL_TRIANGLE_FAN, 0, cnt);
	}

	~this() {
		if (vpeTerminated) return;
		VAOfreeQ.push(VAO);
		VBOfreeQ.push(VBO);
	}
}

private auto VAOfreeQ = new shared GLQueue();
private auto VBOfreeQ = new shared GLQueue();
void freePolygons() {
	GLuint id;
	while (VAOfreeQ.pop(id)) {
		log("Deleting VAO (id = %s)", id);
		glDeleteVertexArrays(1, &id);
	}
	while (VBOfreeQ.pop(id)) {
		log("Deleting VBO (id = %s)", id);
		glDeleteBuffers(1, &id);
	}
}
