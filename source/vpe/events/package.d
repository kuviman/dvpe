module vpe.events;

import vpe.internal;

struct KeyDown { Key key; }
struct KeyUp { Key key; }
struct KeyRepeat { Key key; }

alias TypeTuple!(KeyDown, KeyUp, KeyRepeat) EventTypes;

void clearEvents() {
	foreach (T; EventTypes)
		eventQueue!T = [];
}

auto getEvents(T)() {
	return eventQueue!T[];
}
