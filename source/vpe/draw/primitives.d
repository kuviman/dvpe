/**
 * Functions for rendering primitives
 *
 * Copyright: © 2014 kuviman
 * License: MIT
 * Authors: kuviman
 */
module vpe.draw.primitives;

import vpe.internal;

/// Render a quad (0, 0)-(1, 1)
void quad() {
	colorShader.renderQuad();
}

/// Render a polygon
void polygon(vec2[] points...) {
	auto poly = new RawPolygon(points);
	colorShader.renderPoly(poly);
	poly.free();
}

/// Render a line
void line(vec2 p1, vec2 p2, real width) {
	draw.save();
	draw.translate(p1.x, p1.y);
	draw.rotate((p2 - p1).arg);
	draw.scale((p2 - p1).length, width);
	draw.translate(0, -0.5);
	draw.quad();
	draw.load();
}
/// ditto
void line(real x1, real y1, real x2, real y2, real width) {
	line(vec2(x1, y1), vec2(x2, y2), width);
}

/// Render a dashed line
void dashedLine(vec2 p1, vec2 p2, real width, real gap = -1, real period = -1) {
	if (period < 0) period = width * 7;
	if (gap < 0) gap = width * 2;
	draw.save();
	draw.translate(p1.x, p1.y);
	draw.rotate((p2 - p1).arg);
	auto len = (p2 - p1).length;
	draw.scale(len, width);
	draw.translate(0, -0.5);
	dashedShader.setFloat("period", period / len);
	dashedShader.setFloat("gap", gap / len);
	dashedShader.render();
	draw.load();
}
/// ditto
void dashedLine(real x1, real y1, real x2, real y2, real width, real gap = -1, real period = -1) {
	dashedLine(vec2(x1, y1), vec2(x2, y2), width, gap, period);
}

/// Render a rectangle
void rect(real x1, real y1, real x2, real y2) {
	draw.save();
	draw.translate(x1, y1);
	draw.scale(x2 - x1, y2 - y1);
	draw.quad();
	draw.load();
}
/// ditto
void rect(vec2 p1, vec2 p2) {
	rect(p1.x, p1.y, p2.x, p2.y);
}

/// Render a frame
void frame(real x1, real y1, real x2, real y2, real width) {
	draw.line(x1, y1, x2, y1, width);
	draw.line(x2, y1, x2, y2, width);
	draw.line(x2, y2, x1, y2, width);
	draw.line(x1, y2, x1, y1, width);
}
/// ditto
void frame(vec2 p1, vec2 p2, real width) {
	frame(p1.x, p1.y, p2.x, p2.y, width);
}

/// Render a circle
void circle(real x, real y, real radius) {
	draw.save();
	draw.translate(x - radius, y - radius);
	draw.scale(2 * radius);
	circleShader.render();
	draw.load();
}
/// ditto
void circle(vec2 pos, real radius) {
	circle(pos.x, pos.y, radius);
}
