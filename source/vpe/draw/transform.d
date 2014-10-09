module vpe.draw.transform;

import vpe.internal;

void modelMatrix(mat4 mat) {
	renderState.modelMatrix = mat;
}
