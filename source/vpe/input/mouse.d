/// vpe.input submodule
module vpe.input.mouse;

import vpe.internal;

/// Get or set mouse position
vec2 position() {
	double x, y;
	glfwGetCursorPos(window, &x, &y);
	y = display.height - 1 - y;
	return vec2(x, y);
}
