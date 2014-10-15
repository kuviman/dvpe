module vpe.state;

import vpe.internal;

class State {
	void keyDown(Key key) {}
	void keyRepeat(Key key) {}
	void keyUp(Key key) {}
	void mouseButtonDown(MouseButton button) {}
	void mouseButtonUp(MouseButton button) {}

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

	void update(real dt) {}
	void render() {}

	void close() {
		running = false;
	}

	bool running = false;
}
