module vpe.draw.internal;

public {
	import vpe.draw.internal.state;
	import vpe.draw.internal.target;
}

import vpe.internal;

void initRender() {
	auto font = TTFFont.loadFromMem(importBinary!"font_default.ttf", 16);
	font.style = TTFFont.Style.Bold;
	draw.font = font;
}

void reinitRender() {
	draw.depthTesting = draw.depthTesting;
	draw.blendMode = draw.blendMode;
}
