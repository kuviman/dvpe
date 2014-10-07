module vpe.internal;

public {
	import vpe;
	import vpl;

	import derelict.glfw3.glfw3;
	import derelict.opengl3.gl3;
}

GLFWwindow* window, coreWindow;
bool vpeTerminated = false;

void initalizeVPE() {
	log("Initializing VPE");
	logIndent(); scope(exit) logUnindent();

	log("Loading DerelictGLFW3");
	DerelictGLFW3.load();
	log("Loading DerelictGL3");
	DerelictGL3.load();

	log("Compiled with GLFW version %s.%s.%s", GLFW_VERSION_MAJOR, GLFW_VERSION_MINOR, GLFW_VERSION_REVISION);
	int major, minor, revision;
	glfwGetVersion(&major, &minor, &revision);
	log("Shared GLFW version %s.%s.%s", major, minor, revision);
	log("GLFW version string \"%s\"", glfwGetVersionString().to!string);

	log("Initializing GLFW");
	enforce(glfwInit() == GL_TRUE, "Could not initialize GLFW");

	log("Creating core window");
	version (OSX) {
		glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
		glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
		glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);
		glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
	}
	glfwWindowHint(GLFW_VISIBLE, GL_FALSE);
	window = coreWindow = glfwCreateWindow(1, 1, "VPE core window", null, null);
	enforce(coreWindow, "Could not create core window");

	glfwMakeContextCurrent(coreWindow);
	log("Reloading DerelictGL3");
	DerelictGL3.reload();
}

void terminateVPE() {
	log("Terminating VPE");
	logIndent(); scope(exit) logUnindent();

	log("Teminate GLFW");
	glfwTerminate();

	vpeTerminated = true;
}
