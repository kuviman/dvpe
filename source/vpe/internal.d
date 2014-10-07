module vpe.internal;

import vpe;
import vpl;

import derelict.glfw3.glfw3;
import derelict.opengl3.gl3;

void initalizeVPE() {
	log("Initializing VPE");
	logIndent(); scope(exit) logUnindent();

	log("Loading DerelictGLFW3");
	DerelictGLFW3.load();

	log("Compiled with GLFW version %s.%s.%s", GLFW_VERSION_MAJOR, GLFW_VERSION_MINOR, GLFW_VERSION_REVISION);
	int major, minor, revision;
	glfwGetVersion(&major, &minor, &revision);
	log("Shared GLFW version %s.%s.%s", major, minor, revision);
	log("GLFW version string \"%s\"", glfwGetVersionString().to!string);

	log("Initializing GLFW");
	enforce(glfwInit() == GL_TRUE, "Could not initialize GLFW");
}

void terminateVPE() {
	log("Terminating VPE");
	logIndent(); scope(exit) logUnindent();

	log("Teminate GLFW");
	glfwTerminate();
}
