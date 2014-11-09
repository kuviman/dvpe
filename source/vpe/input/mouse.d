/**
 * Mouse related functions
 *
 * Copyright: © 2014 kuviman
 * License: MIT
 * Authors: kuviman
 */
module vpe.input.mouse;

import vpe.internal;

/// Get or set mouse position
vec2 position() {
	double x, y;
	glfwGetCursorPos(window, &x, &y);
	y = display.height - 1 - y;
	return vec2(x, y);
}

/// Check if a mouse button is pressed
bool pressed(MouseButton button) {
	return glfwGetMouseButton(window, button) == GLFW_PRESS;
}
