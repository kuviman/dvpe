module vpe.draw.internal;

public {
	import vpe.draw.internal.state;
	import vpe.draw.internal.target;
}

import vpe.internal;

void initRender() {
	draw.font = TTFFont.loadFromMem(importBinary!"font/default.ttf", 16);
}

void reinitRender() {
	draw.depthTesting = draw.depthTesting;
	glEnable(GL_BLEND);
	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
}
