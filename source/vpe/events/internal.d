module vpe.events.internal;

import vpe.internal;

template eventQueue(T) { T[] eventQueue; };

void registerEvents(GLFWwindow* window) {
	glfwSetKeyCallback(window, &cbKey);
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
