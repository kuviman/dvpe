module vpe.input.keyboard;

import vpe.internal;

bool pressed(Key key) {
	return glfwGetKey(window, key) == GLFW_PRESS;
}
