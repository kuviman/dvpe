/**
 * Rendering to the area
 *
 * Sometimes you need to render only to a part of the screen/texture
 *
 * Examples:
 *	Rendering to right half of the screen
 * ---
 *	draw.beginArea(draw.width / 2, 0, draw.width / 2, draw.height);
 *	// Render right half of the screen
 *	draw.endArea();
 * ---
 *
 * Copyright: © 2014 kuviman
 * License: MIT
 * Authors: kuviman
 */
module vpe.draw.area;

import vpe.internal;

package {
	vec2i[] renderAreaPosStack, renderAreaSizeStack;
	vec2i renderAreaPos() {
		if (renderAreaPosStack.length == 0)
			return vec2i(0, 0);
		return renderAreaPosStack[$ - 1];
	}
	void applyArea() {
		alias renderAreaPos pos;
		alias draw.size size;
		glEnable(GL_SCISSOR_TEST);
		glViewport(pos.x, pos.y, size.x, size.y);
		glScissor(pos.x, pos.y, size.x, size.y);
	}
}

/**
 * Begin rendering to area
 * Params:
 *	x = left coordinate of the area
 *	y = bottom coordinate of the area
 *	w = width of the area
 *	h = height of the area
 */
void beginArea(int x, int y, int w, int h) {
	renderAreaPosStack ~= renderAreaPos + vec2i(x, y);
	renderAreaSizeStack ~= vec2i(w, h);
	applyArea();
}

/// End rendering to area
void endArea() {
	renderAreaPosStack = renderAreaPosStack[0..$ - 1];
	renderAreaSizeStack = renderAreaSizeStack[0..$ - 1];
	applyArea();
}
