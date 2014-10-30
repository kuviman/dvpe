module vpe.raw.polygon;

import vpe.internal;

class RawPolygon {
	GLuint VAO, VBO;
	int cnt;

	vec3[] points;

	this(vec2[] points...) {
		vec3[] p3;
		foreach (p; points)
			p3 ~= vec3(p.x, p.y, 0);
		this(p3);
	}
	this(vec3[] points...) {
		this.points = points.dup;
	}

	void init() {
		version(OpenGL2) {}
		else {
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
	}

	void initAttr(GLint loc) {
		if (loc == -1) return;
		glVertexAttribPointer(loc, 3, GL_FLOAT, GL_FALSE, GLfloat.sizeof * 3, null);
		glEnableVertexAttribArray(loc);
	}

	void render(RawProgram program) {
		if (myWindow !is window) {
			init();
			myWindow = window;
		}
		version(OpenGL2) {
			glBegin(GL_TRIANGLE_FAN);
			foreach(pos; points)
				glVertex3f(pos.x, pos.y, pos.z);
			glEnd();
		} else {
			glBindBuffer(GL_ARRAY_BUFFER, VBO);
			glBindVertexArray(VAO);
			GLint posLoc = glGetAttribLocation(program, "position");
			initAttr(posLoc);
			glDrawArrays(GL_TRIANGLE_FAN, 0, cnt);
		}
	}

	~this() {
		if (vpeTerminated) return;

		// Should not delete if created in another window

		//VAOfreeQ.push(VAO);
		//VBOfreeQ.push(VBO);
	}

	void free() {
		glDeleteVertexArrays(1, &VAO);
		glDeleteBuffers(1, &VBO);
	}

	GLFWwindow* myWindow = null;
}

private auto VAOfreeQ = new shared SynQueue!GLuint();
private auto VBOfreeQ = new shared SynQueue!GLuint();
void freePolygons() {
	GLuint id;
	while (VAOfreeQ.pop(id)) {
		//log("Deleting VAO (id = %s)", id);
		glDeleteVertexArrays(1, &id);
	}
	while (VBOfreeQ.pop(id)) {
		//log("Deleting VBO (id = %s)", id);
		glDeleteBuffers(1, &id);
	}
}
