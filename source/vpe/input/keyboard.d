/**
 * Keyboard related functions
 *
 * Copyright: © 2014 kuviman
 * License: MIT
 * Authors: kuviman
 */
module vpe.input.keyboard;

import vpe.internal;

/// Check if a key is pressed
bool pressed(Key key) {
	return glfwGetKey(window, key) == GLFW_PRESS;
}
