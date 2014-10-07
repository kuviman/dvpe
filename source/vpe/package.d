module vpe;

public {
}

import vpe.internal;

static this() {
	initalizeVPE();
}
static ~this() {
	terminateVPE();
}
