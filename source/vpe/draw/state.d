module vpe.draw.state;

import vpe.internal;

struct RenderState {
	Color color = Color(1, 1, 1, 1);
	mat4 modelMatrix;

	void apply(Shader shader) {
		shader.setColor("color", color);
		shader.setMat4("modelMatrix", modelMatrix);
	}
}

RenderState renderState;
