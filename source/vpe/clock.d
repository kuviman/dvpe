/**
 * Time management
 *
 * Copyright: © 2014 kuviman
 * License: MIT
 * Authors: kuviman
 */
module vpe.clock;

import vpe.internal;
import std.container : DList;

/// Clock
class Clock {
	private real oldTime;
	private real startTime;
	/// Create a clock
	this() {
		startTime = oldTime = glfwGetTime();
	}
	/**
	 * Tick
	 * Returns: time since last tick
	 */
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
	/// Get current time
	real currentTime() {
		return glfwGetTime() - startTime;
	}

	/// Get current FPS
	real FPS() {
		if (cntFrames == 0) return 0;
		return cntFrames / sumFrames;
	}

	private size_t cntFrames = 0;
	private DList!real lastFrames;
	private enum NeedFrames = 20;
	private real sumFrames = 0;
}
