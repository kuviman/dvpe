/// vpe.draw submodule
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

/// Begin rendering to area
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
