/**
 * Managing events
 *
 * Copyright: © 2014 kuviman
 * License: MIT
 * Authors: kuviman
 */
module vpe.events;

import vpe.internal;

/// Key down event
struct KeyDown {
	/// Pressed key
	Key key;
}
/// Key up event
struct KeyUp {
	/// Released key
	Key key;
}
/// Key repeat event
struct KeyRepeat {
	/// Repeated key
	Key key;
}

/// Mouse button down event
struct MouseButtonDown {
	/// Pressed button
	MouseButton button;
}
/// Mouse button up event
struct MouseButtonUp {
	/// Released button
	MouseButton button;
}

/// Scroll event
struct Scroll {
	real dx; /// _Scroll value
	real dy; /// ditto
	/// ditto
	vec2 dv() { return vec2(dx, dy); }
}

/// Quit event
struct Quit {}

/// All event types
alias TypeTuple!(
	KeyDown, KeyUp, KeyRepeat,
	MouseButtonDown, MouseButtonUp,
	Scroll, Quit)
		EventTypes;

/// Clear event queue
void clearEvents() {
	foreach (T; EventTypes)
		eventQueue!T = [];
}

/// Get all events of the given type
auto getEvents(T)() {
	return eventQueue!T[];
}

/// Check if there is a given event in the queue
bool gotEvent(T, Args...)(Args args) {
	static if (Args.length == 0) { return eventQueue!T.length > 0; }
	else {
		foreach (e; eventQueue!T)
			if (e == T(args))
				return true;
		return false;
	}
}
