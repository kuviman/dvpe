module vpe.draw;

public {
}

import vpe.internal;

void clear(real r, real g, real b, real a = 1) {
	glClearColor(r, g, b, a);
	glClear(GL_COLOR_BUFFER_BIT);
}
