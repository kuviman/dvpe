module vpe.draw.transform;

import vpe.internal;

void modelMatrix(mat4 mat) { renderState.modelMatrix = mat; }
void multMatrix(mat4 mat) { renderState.modelMatrix = renderState.modelMatrix * mat; }

void rotate(real angle) { multMatrix(mat4.createRotation(vec3(0, 0, 1), angle)); }

void scale(real k) { multMatrix(mat4.createScale(k)); }
void scale(real kx, real ky, real kz = 1) { multMatrix(mat4.createScale(kx, ky, kz)); }

void translate(real x, real y, real z = 0) { multMatrix(mat4.createTranslation(x, y, z)); }

void view(real fov, real aspect) {
	real w = fov * aspect / 2;
	real h = fov / 2;
	renderState.projectionMatrix = mat4.createScale(1 / w, 1 / h, 1);
}
void view(real fov) {
	view(fov, draw.aspect);
}
