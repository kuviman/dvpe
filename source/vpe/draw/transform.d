/**
 * Transformations of the model / projection matrix
 *
 * Do not forget to save/load render state when you apply transformations
 *
 * Keep in mind that transformations are actually applied in reverse order.
 * If you want something to be rotated, you do:
 * ---
 *	draw.save();
 *	draw.rotate(angle)
 *	// Everything now is going to be rotated (after all local transformations)
 *	draw.load();
 * ---
 *
 * Examples:
 *	Rendering a rect with lower-left corner at (x, y) and size (w, h)
 * ---
 *	draw.save(); // Save current rendering state
 *	draw.translate(x, y)
 *	draw.scale(w, h);
 *	draw.quad();
 *	draw.load(); // Cancel transformations
 * ---
 *
 * Copyright: © 2014 kuviman
 * License: MIT
 * Authors: kuviman
 */
module vpe.draw.transform;

import vpe.internal;

/// Set model matrix
void modelMatrix(mat4 mat) { renderState.modelMatrix = mat; }

/** Multiply model matrix
 * ---
 *	newModelMatrix = currentModelMatrix * mat;
 * ---
 */
void multMatrix(mat4 mat) { renderState.modelMatrix = renderState.modelMatrix * mat; }

/** Rotate model
 * Params:
 *	angle = rotations angle in radians
 */
void rotate(real angle) { multMatrix(mat4.createRotation(vec3(0, 0, 1), angle)); }

/**
 * Scale model
 * Params:
 *	k = scale factor
 *	kx = x scale factor
 *	ky = y scale factor
 *	kz = z scale factor
 */
void scale(real k) { multMatrix(mat4.createScale(k)); }
/// ditto
void scale(real kx, real ky, real kz = 1) { multMatrix(mat4.createScale(kx, ky, kz)); }

/**
 * Translate model
 * Params:
 *	x = translation along x axis
 *	y = translation along y axis
 *	z = translation along z axis
 */
void translate(real x, real y, real z = 0) { multMatrix(mat4.createTranslation(x, y, z)); }

/**
 * Set up the view
 *
 * Sets the view so that distance between bottom and top of the screen equals to fov.
 * Center of the screen will be (0, 0).
 * If aspect is not given, draw.aspect is used instead.
 *
 * Examples:
 *	Set up the view where (0, 0) is bottom left corner of the screen and
 * (draw.width, draw.height) is top right corner
 * ---
 *	draw.save();
 *	draw.view(draw.height);
 *	draw.translate(-draw.width / 2, -draw.height / 2);
 *	// Render some stuff
 *	draw.load();
 * ---
 */
void view(real fov, real aspect) {
	real w = fov * aspect / 2;
	real h = fov / 2;
	renderState.projectionMatrix = mat4.createScale(1 / w, 1 / h, 1);
}
/// ditto
void view(real fov) {
	view(fov, draw.aspect);
}
