module vpe.events;

import vpe.internal;

struct KeyDown { Key key; }
struct KeyUp { Key key; }
struct KeyRepeat { Key key; }

struct MouseButtonDown { MouseButton button; }
struct MouseButtonUp { MouseButton button; }

struct Quit {}

alias TypeTuple!(
	KeyDown, KeyUp, KeyRepeat,
	MouseButtonUp, MouseButtonDown,
	Quit)
		EventTypes;

void clearEvents() {
	foreach (T; EventTypes)
		eventQueue!T = [];
}

auto getEvents(T)() {
	return eventQueue!T[];
}

bool gotEvent(T, Args...)(Args args) {
	static if (Args.length == 0) { return eventQueue!T.length > 0; }
	else {
		foreach (e; eventQueue!T)
			if (e == T(args))
				return true;
		return false;
	}
}
