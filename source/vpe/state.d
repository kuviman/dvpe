/**
 * State management
 *
 * Alternative to oldschool mainloop
 *
 * Examples:
 *	Render blue background
 * ---
 *	class Test : State {
 *		override void render() { draw.clear(Color.Blue); }
 *	}
 *	void main() { new Test().run(); }
 * ---
 *
 * Copyright: © 2014 kuviman
 * License: MIT
 * Authors: kuviman
 */
module vpe.state;

import vpe.internal;

/// Abstract state
abstract class State {
	/// keyDown event handler
	void keyDown(Key key) {}
	/// keyRepeat event handler
	void keyRepeat(Key key) {}
	/// keyUp event handler
	void keyUp(Key key) {}
	/// mouseButtonDown event handler
	void mouseButtonDown(MouseButton button) {}
	/// mouseButtonUp event handler
	void mouseButtonUp(MouseButton button) {}

	/// Run the mainloop
	void run() {
		auto clock = new Clock();
		running = true;
		while (running) {
			foreach (e; getEvents!KeyDown)
				keyDown(e.key);
			foreach (e; getEvents!KeyUp)
				keyUp(e.key);
			foreach (e; getEvents!MouseButtonDown)
				mouseButtonDown(e.button);
			foreach (e; getEvents!MouseButtonUp)
				mouseButtonUp(e.button);
			if (gotEvent!Quit)
				running = false;
			update(clock.tick());
			render();
			display.flip();
		}
	}

	/// Update the state
	void update(real dt) {}
	/// Render
	void render() {}

	/// Stop running
	void close() {
		running = false;
	}

	bool running = false;
}
