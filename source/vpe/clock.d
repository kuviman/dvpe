module vpe.clock;

import vpe.internal;

class Clock {
	private real oldTime;
	private real startTime;
	this() {
		startTime = oldTime = glfwGetTime();
	}
	real tick() {
		auto newTime = glfwGetTime();
		auto dt = newTime - oldTime;
		oldTime = newTime;
		return dt;
	}
	real currentTime() {
		return glfwGetTime() - startTime;
	}
}
