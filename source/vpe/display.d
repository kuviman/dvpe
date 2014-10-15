module vpe.display;

import vpe.internal;

debug enum defaultFullscreen = false;
else enum defaultFullscreen = true;
enum defaultWidth = 640, defaultHeight = 480;

private bool _fullscreen = defaultFullscreen;
bool fullscreen() { return _fullscreen; }
void fullscreen(bool value) {
	setMode(-1, -1, value);
}

private void setDefaultMode() {
	setMode(-1, -1, fullscreen);
}

private string _title = "VPE application";
string title() { return _title; }
void title(string value) {
	_title = value;
	if (window !is null)
		glfwSetWindowTitle(window, value.toStringz);
}

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
	log("Switching OpenGL context to new window");
	glfwMakeContextCurrent(window);

	log("Registering events for new window");
	registerEvents(window);

	reinitRender();
}

vec2i size() {
	vec2i res;
	glfwGetWindowSize(window, &res.x(), &res.y());
	return res;
}
int width() { return size.x; }
int height() { return size.y; }
real aspect() { return cast(real) width / height; }

void flip() {
	if (window is coreWindow)
		setDefaultMode();
	clearEvents();
	glfwPollEvents();
	glfwSwapBuffers(window);
	if (glfwWindowShouldClose(window)) {
		eventQueue!Quit ~= Quit();
		glfwSetWindowShouldClose(window, GL_FALSE);
	}
	freeResources();
}
