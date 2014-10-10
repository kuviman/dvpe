module vpe.events.internal;

import vpe.internal;

template eventQueue(T) { T[] eventQueue; };

void registerEvents(GLFWwindow* window) {
	glfwSetKeyCallback(window, &cbKey);
	glfwSetMouseButtonCallback(window, &cbMouseButton);
	glfwSetScrollCallback(window, &cbScroll);
}

nothrow extern(C) void cbKey(GLFWwindow* window, int key, int scancode, int action, int mods) {
	try {
		if (action == GLFW_PRESS)
			eventQueue!KeyDown ~= KeyDown(cast(Key)key);
		else if (action == GLFW_RELEASE)
			eventQueue!KeyUp ~= KeyUp(cast(Key)key);
		else if (action == GLFW_REPEAT)
			eventQueue!KeyRepeat ~= KeyRepeat(cast(Key)key);
	} catch (Exception) {}
}

nothrow extern(C) void cbMouseButton(GLFWwindow* window, int button, int action, int mods) {
	try {
		if (action == GLFW_PRESS)
			eventQueue!MouseButtonDown ~= MouseButtonDown(cast(MouseButton)button);
		else if (action == GLFW_RELEASE)
			eventQueue!MouseButtonUp ~= MouseButtonUp(cast(MouseButton)button);
	} catch (Exception) {}
}

nothrow extern(C) void cbScroll(GLFWwindow* window, double dx, double dy) {
	try {
		eventQueue!Scroll ~= Scroll(dx, -dy);
	} catch (Exception) {}
}
