module vpe.draw.state;

import vpe.internal;

struct RenderState {
	Color color = Color(1, 1, 1, 1);

	void apply(Shader shader) {
		shader.setColor("color", color);
	}
}

RenderState renderState;
