module vpe.clock;

import vpe.internal;
import std.container : DList;

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

		sumFrames += dt;
		lastFrames.insertBack(dt);
		cntFrames++;

		while (cntFrames > NeedFrames) {
			sumFrames -= lastFrames.front();
			lastFrames.removeFront();
			cntFrames--;
		}

		return dt;
	}
	real currentTime() {
		return glfwGetTime() - startTime;
	}

	real FPS() {
		if (cntFrames == 0) return 0;
		return cntFrames / sumFrames;
	}

	private size_t cntFrames = 0;
	private DList!real lastFrames;
	private enum NeedFrames = 20;
	private real sumFrames = 0;
}
