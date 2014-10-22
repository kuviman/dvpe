/// vpe.draw submodule
module vpe.draw.transform;

import vpe.internal;

/// Set model matrix
void modelMatrix(mat4 mat) { renderState.modelMatrix = mat; }

/// Multiply model matrix
void multMatrix(mat4 mat) { renderState.modelMatrix = renderState.modelMatrix * mat; }

/// Rotate model
void rotate(real angle) { multMatrix(mat4.createRotation(vec3(0, 0, 1), angle)); }

/// Scale model
void scale(real k) { multMatrix(mat4.createScale(k)); }
/// ditto
void scale(real kx, real ky, real kz = 1) { multMatrix(mat4.createScale(kx, ky, kz)); }

/// Translate model
void translate(real x, real y, real z = 0) { multMatrix(mat4.createTranslation(x, y, z)); }

/// Set up the view
void view(real fov, real aspect) {
	real w = fov * aspect / 2;
	real h = fov / 2;
	renderState.projectionMatrix = mat4.createScale(1 / w, 1 / h, 1);
}
/// ditto
void view(real fov) {
	view(fov, draw.aspect);
}
