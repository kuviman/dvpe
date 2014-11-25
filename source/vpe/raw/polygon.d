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
			//log("Creating VAO (id = %s)", VAO);
			glBindVertexArray(VAO);
			glGenBuffers(1, &VBO);
			//log("Creating VBO (id = %s)", VBO);
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
		if (vpeTerminated || myWindow is null) return;
		VAOfreeQ.push(STuple(myWindow, VAO));
		VBOfreeQ.push(STuple(myWindow, VBO));
	}

	void free() {
		if (window !is myWindow) return;
		glDeleteVertexArrays(1, &VAO);
		glDeleteBuffers(1, &VBO);
		myWindow = null;
	}

	GLFWwindow* myWindow = null;
}

private struct STuple {
	GLFWwindow* window;
	GLuint id;
};
private auto VAOfreeQ = new shared SynQueue!STuple();
private auto VBOfreeQ = new shared SynQueue!STuple();
void freePolygons() {
	STuple stupr;
	while (VAOfreeQ.pop(stupr)) {
		if (stupr.window !is window) continue;
		//log("Deleting VAO (id = %s)", stupr.id);
		glDeleteVertexArrays(1, &stupr.id);
	}
	while (VBOfreeQ.pop(stupr)) {
		if (stupr.window !is window) continue;
		//log("Deleting VBO (id = %s)", stupr.id);
		glDeleteBuffers(1, &stupr.id);
	}
}
