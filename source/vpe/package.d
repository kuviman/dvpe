module vpe;

public {
	import vpe.clock;
}

import vpe.internal;

static this() {
	initalizeVPE();
}
static ~this() {
	terminateVPE();
}
