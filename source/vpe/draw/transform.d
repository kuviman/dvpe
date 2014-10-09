module vpe.draw.transform;

import vpe.internal;

void modelMatrix(mat4 mat) { renderState.modelMatrix = mat; }
void multMatrix(mat4 mat) { renderState.modelMatrix = renderState.modelMatrix * mat; }

void rotate(real angle) { multMatrix(mat4.createRotation(vec3(0, 0, 1), angle)); }

void scale(real k) { multMatrix(mat4.createScale(k)); }
void scale(real kx, real ky, real kz = 1) { multMatrix(mat4.createScale(kx, ky, kz)); }

void translate(real x, real y, real z = 0) { multMatrix(mat4.createTranslation(x, y, z)); }
