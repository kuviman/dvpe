module vpe.draw;

public {
}

import vpe.internal;

void clear(real r, real g, real b, real a = 1) {
	glClearColor(r, g, b, a);
	glClear(GL_COLOR_BUFFER_BIT);
}
void clear(Color color) { clear(color.r, color.g, color.b, color.a); }

void quad() {
	colorShader.renderQuad();
}

void color(Color color) {
	renderState.color = color;
}
void color(real r, real g, real b, real a = 1) {
	renderState.color = Color(r, g, b, a);
}
