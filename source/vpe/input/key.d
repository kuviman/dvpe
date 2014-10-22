/// vpe.input submodule
module vpe.input.key;

import vpe.internal;

/// Key
enum Key {
	Space = GLFW_KEY_SPACE, /// Space
	Apostrophe = GLFW_KEY_APOSTROPHE, /// Apostrophe
	Comma = GLFW_KEY_COMMA, /// Comma
	Minus = GLFW_KEY_MINUS, /// Minus
	Period = GLFW_KEY_PERIOD, /// Period
	Slash = GLFW_KEY_SLASH, /// Slash

	Num0 = GLFW_KEY_0, /// Num0
	Num1 = GLFW_KEY_1, /// Num1
	Num2 = GLFW_KEY_2, /// Num2
	Num3 = GLFW_KEY_3, /// Num3
	Num4 = GLFW_KEY_4, /// Num4
	Num5 = GLFW_KEY_5, /// Num5
	Num6 = GLFW_KEY_6, /// Num6
	Num7 = GLFW_KEY_7, /// Num7
	Num8 = GLFW_KEY_8, /// Num8
	Num9 = GLFW_KEY_9, /// Num9

	Semicolon = GLFW_KEY_SEMICOLON, /// Semicolon
	Equal = GLFW_KEY_EQUAL, /// Equal

	A = GLFW_KEY_A, /// A
	B = GLFW_KEY_B, /// B
	C = GLFW_KEY_C, /// C
	D = GLFW_KEY_D, /// D
	E = GLFW_KEY_E, /// E
	F = GLFW_KEY_F, /// F
	G = GLFW_KEY_G, /// G
	H = GLFW_KEY_H, /// H
	I = GLFW_KEY_I, /// I
	J = GLFW_KEY_J, /// J
	K = GLFW_KEY_K, /// K
	L = GLFW_KEY_L, /// L
	M = GLFW_KEY_M, /// M
	N = GLFW_KEY_N, /// N
	O = GLFW_KEY_O, /// O
	P = GLFW_KEY_P, /// P
	Q = GLFW_KEY_Q, /// Q
	R = GLFW_KEY_R, /// R
	S = GLFW_KEY_S, /// S
	T = GLFW_KEY_T, /// T
	U = GLFW_KEY_U, /// U
	V = GLFW_KEY_V, /// V
	W = GLFW_KEY_W, /// W
	X = GLFW_KEY_X, /// X
	Y = GLFW_KEY_Y, /// Y
	Z = GLFW_KEY_Z, /// Z

	LeftBracket = GLFW_KEY_LEFT_BRACKET, /// LeftBracket
	Backslash = GLFW_KEY_BACKSLASH, /// Backslash
	RightBracket = GLFW_KEY_RIGHT_BRACKET, /// RightBracket
	Escape = GLFW_KEY_ESCAPE, /// Escape
	Enter = GLFW_KEY_ENTER, /// Enter
	Tab = GLFW_KEY_TAB, /// Tab
	Backspace = GLFW_KEY_BACKSPACE, /// Backspace
	Insert = GLFW_KEY_INSERT, /// Insert
	Delete = GLFW_KEY_DELETE, /// Delete

	Right = GLFW_KEY_RIGHT, /// Right
	Left = GLFW_KEY_LEFT, /// Left
	Down = GLFW_KEY_DOWN, /// Down
	Up = GLFW_KEY_UP, /// Up

	PageUp = GLFW_KEY_PAGE_UP, /// PageUp
	PageDown = GLFW_KEY_PAGE_DOWN, /// PageDown
	Home = GLFW_KEY_HOME, /// Home
	End = GLFW_KEY_END, /// End
	CapsLock = GLFW_KEY_CAPS_LOCK, /// CapsLock
	ScrollLock = GLFW_KEY_SCROLL_LOCK, /// ScrollLock
	NumLock = GLFW_KEY_NUM_LOCK, /// NumLock
	Pause = GLFW_KEY_PAUSE, /// Pause

	F1 = GLFW_KEY_F1, /// F1
	F2 = GLFW_KEY_F2, /// F2
	F3 = GLFW_KEY_F3, /// F3
	F4 = GLFW_KEY_F4, /// F4
	F5 = GLFW_KEY_F5, /// F5
	F6 = GLFW_KEY_F6, /// F6
	F7 = GLFW_KEY_F7, /// F7
	F8 = GLFW_KEY_F8, /// F8
	F9 = GLFW_KEY_F9, /// F9
	F10 = GLFW_KEY_F10, /// F10
	F11 = GLFW_KEY_F11, /// F11
	F12 = GLFW_KEY_F12, /// F12

	KeyPad0 = GLFW_KEY_KP_0, /// KeyPad0
	KeyPad1 = GLFW_KEY_KP_1, /// KeyPad1
	KeyPad2 = GLFW_KEY_KP_2, /// KeyPad2
	KeyPad3 = GLFW_KEY_KP_3, /// KeyPad3
	KeyPad4 = GLFW_KEY_KP_4, /// KeyPad4
	KeyPad5 = GLFW_KEY_KP_5, /// KeyPad5
	KeyPad6 = GLFW_KEY_KP_6, /// KeyPad6
	KeyPad7 = GLFW_KEY_KP_7, /// KeyPad7
	KeyPad8 = GLFW_KEY_KP_8, /// KeyPad8
	KeyPad9 = GLFW_KEY_KP_9, /// KeyPad9

	KeyPadDecimal = GLFW_KEY_KP_DECIMAL, /// KeyPadDecimal
	KeyPadDivide = GLFW_KEY_KP_DIVIDE, /// KeyPadDivide
	KeyPadMultiply = GLFW_KEY_KP_MULTIPLY, /// KeyPadMultiply
	KeyPadSubtract = GLFW_KEY_KP_SUBTRACT, /// KeyPadSubtract
	KeyPadAdd = GLFW_KEY_KP_ADD, /// KeyPadAdd
	KeyPadEnter = GLFW_KEY_KP_ENTER, /// KeyPadEnter
	KeyPadEqual = GLFW_KEY_KP_EQUAL, /// KeyPadEqual

	LeftShift = GLFW_KEY_LEFT_SHIFT, /// LeftShift
	LeftControl = GLFW_KEY_LEFT_CONTROL, /// LeftControl
	LeftAlt = GLFW_KEY_LEFT_ALT, /// LeftAlt
	LeftSuper = GLFW_KEY_LEFT_SUPER, /// LeftSuper
	RightShift = GLFW_KEY_RIGHT_SHIFT, /// RightShift
	RightControl = GLFW_KEY_RIGHT_CONTROL, /// RightControl
	RightAlt = GLFW_KEY_RIGHT_ALT, /// RightAlt
	RightSuper = GLFW_KEY_RIGHT_SUPER, /// RightSuper

	Menu = GLFW_KEY_MENU /// Menu
}
