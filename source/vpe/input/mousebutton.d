/// vpe.input submodule
module vpe.input.mousebutton;

import vpe.internal;

/// Mouse button
enum MouseButton {
	/// Left mouse button
	Left = GLFW_MOUSE_BUTTON_1,
	/// Middle mouse button
	Middle = GLFW_MOUSE_BUTTON_3,
	/// Right mouse button
	Right = GLFW_MOUSE_BUTTON_2
}
