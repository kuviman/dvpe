module vpe.draw.state;

import vpe.internal;

struct RenderState {
	Color color = Color(1, 1, 1, 1);
	mat4 modelMatrix = mat4.identity;

	void apply(Shader shader) {
		shader.setColor("color", color);
		shader.setMat4("modelMatrix", modelMatrix);
	}
}

RenderState renderState;
RenderState[] renderStateStack;

void saveRenderState() { renderStateStack ~= renderState; }
void loadRenderState() {
	alias renderStateStack stack;
	renderState = stack[$ - 1];
	stack = stack[0..$ - 1];
}
