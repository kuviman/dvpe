/**
 * Display manipulation
 *
 * Copyright: © 2014 kuviman
 * License: MIT
 * Authors: kuviman
 */
module vpe.display;

import vpe.internal;

debug enum defaultFullscreen = false;
else enum defaultFullscreen = true;
enum defaultWidth = 640, defaultHeight = 480;

private bool _fullscreen = defaultFullscreen;

/// Get or set fullscreen
bool fullscreen() { return _fullscreen; }
/// ditto
void fullscreen(bool value) {
	setMode(-1, -1, value);
}

private void setDefaultMode() {
	setMode(-1, -1, fullscreen);
}

private string _title = "VPE application";

/// Get or set title
string title() { return _title; }
/// ditto
void title(string value) {
	_title = value;
	if (window !is null)
		glfwSetWindowTitle(window, value.toStringz);
}

/// Set video mode
void setMode(int width, int height, bool fullscreen = defaultFullscreen) {
	_fullscreen = fullscreen;
	GLFWmonitor* monitor = fullscreen ? glfwGetPrimaryMonitor() : null;
	if (width < 0) {
		if (fullscreen) {
			auto mode = glfwGetVideoMode(monitor);
			width = mode.width;
			height = mode.height;
		} else {
			width = defaultWidth;
			height = defaultHeight;
		}
	}
	log("Setting display mode to width = %s, height = %s, fullscreen = %s", width, height, fullscreen);
	logIndent(); scope(exit) logUnindent();
	if (window !is null && window !is coreWindow) {
		log("Destroying old window");
		glfwDestroyWindow(window);
	}
	glfwWindowHint(GLFW_VISIBLE, GL_TRUE);
	window = glfwCreateWindow(width, height, title.toStringz, monitor, coreWindow);
	enforce(window, "Could not create window");

	log("Registering events for new window");
	registerEvents(window);
	
	log("Switching OpenGL context to new window");
	glfwMakeContextCurrent(window);
	gl.glGetError(); // Ignore

	reinitRender();
}

/// Get window size
vec2i size() {
	vec2i res;
	glfwGetWindowSize(window, &res.x(), &res.y());
	return res;
}
/// Get window width
int width() { return size.x; }
/// Get window height
int height() { return size.y; }
/// Get window aspect
real aspect() { return cast(real) width / height; }

/// Swap buffers & update event queue
void flip() {
	if (window is coreWindow)
		setDefaultMode();
	clearEvents();
	glfwPollEvents();
	glfwSwapBuffers(window);
	if (glfwWindowShouldClose(window)) {
		eventQueue!Quit ~= Quit();
		//glfwSetWindowShouldClose(window, GL_FALSE);
	}
	freeResources();
}
