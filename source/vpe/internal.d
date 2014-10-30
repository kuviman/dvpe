module vpe.internal;

public {
	import vpe;
	import vpl;

	import derelict.glfw3.glfw3;
	version(OpenGL2)
		import derelict.opengl3.gl;
	else
		import derelict.opengl3.gl3;
	import derelict.sdl2.image;
	import derelict.sdl2.sdl;
	import derelict.sdl2.ttf;

	import vpe.raw;
	import vpe.shader.internal;
	import vpe.draw.internal;
	import vpe.events.internal;
	import vpe.texture.internal;
}

GLFWwindow* window, coreWindow;
bool vpeTerminated = false;

nothrow extern(C) void cbError(int num, const(char)* msg) {
	try {
		log("Error %s: %s", num, msg.to!string);
	} catch (Exception) {}
}

void initalizeVPE() {
	log("Initializing VPE");
	logIndent(); scope(exit) logUnindent();

	version(OpenGL2)
		log("Using OpenGL2");

	log("Loading DerelictGLFW3");
	DerelictGLFW3.load();
	version(OpenGL2) {
		log("Loading DerelictGL");
		DerelictGL.load();
	} else {
		log("Loading DerelictGL3");
		DerelictGL3.load();
	}
	log("Loading DerelictSDL2");
	DerelictSDL2.load();
	log("Loading DerelictSDL2Image");
	DerelictSDL2Image.load();
	log("Loading DerelictSDL2ttf");
	DerelictSDL2ttf.load();

	log("Compiled with GLFW version %s.%s.%s", GLFW_VERSION_MAJOR, GLFW_VERSION_MINOR, GLFW_VERSION_REVISION);
	int major, minor, revision;
	glfwGetVersion(&major, &minor, &revision);
	log("Shared GLFW version %s.%s.%s", major, minor, revision);
	log("GLFW version string \"%s\"", glfwGetVersionString().to!string);

	glfwSetErrorCallback(&cbError);

	log("Initializing GLFW");
	enforce(glfwInit() == GL_TRUE, "Could not initialize GLFW");

	// ??? Initializing SDL breaks trackpad
	//log("Initializing SDL");
	//enforce(SDL_Init(SDL_INIT_EVERYTHING) == 0, "Could not initialize SDL");

	log("Initializing SDL_image");
	auto flags = IMG_INIT_JPG | IMG_INIT_PNG | IMG_INIT_TIF;
	enforce(IMG_Init(flags) == flags, "Could not initialize SDL_image");

	log("Initializing SDL_ttf");
	enforce(TTF_Init() == 0, "Could not initialize SDL_ttf");

	log("Creating core window");
	version(OpenGL2) {}
	else version(OSX) {
		glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
		glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
		glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);
		glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
	}
	glfwWindowHint(GLFW_VISIBLE, GL_FALSE);
	window = coreWindow = glfwCreateWindow(1, 1, "VPE core window", null, null);
	enforce(coreWindow, "Could not create core window");

	glfwMakeContextCurrent(coreWindow);
	version(OpenGL2) {
		log("Reloading DerelictGL");
		DerelictGL.reload();
	} else {
		log("Reloading DerelictGL3");
		DerelictGL3.reload();
	}

	{
		log("Initializing shaders");
		logIndent(); scope(exit) logUnindent();
		initShaders();
	}
	initRender();
	log("VPE initialized");
}

void terminateVPE() {
	log("Terminating VPE");
	logIndent(); scope(exit) logUnindent();

	log("Teminate GLFW");
	glfwTerminate();

	vpeTerminated = true;
}
