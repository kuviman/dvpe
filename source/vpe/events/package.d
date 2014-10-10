module vpe.events;

import vpe.internal;

struct KeyDown { Key key; }
struct KeyUp { Key key; }
struct KeyRepeat { Key key; }

struct MouseButtonDown { MouseButton button; }
struct MouseButtonUp { MouseButton button; }

alias TypeTuple!(
	KeyDown, KeyUp, KeyRepeat,
	MouseButtonUp, MouseButtonDown) EventTypes;

void clearEvents() {
	foreach (T; EventTypes)
		eventQueue!T = [];
}

auto getEvents(T)() {
	return eventQueue!T[];
}
