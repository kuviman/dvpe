module vpe.draw.primitives;

import vpe.internal;

void quad() {
	colorShader.renderQuad();
}

void polygon(vec2[] points...) {
	auto poly = new RawPolygon(points);
	colorShader.renderPoly(poly);
	//poly.free();
}

void line(vec2 p1, vec2 p2, real width) {
	draw.save();
	draw.translate(p1.x, p1.y);
	draw.rotate((p2 - p1).arg);
	draw.scale((p2 - p1).length, width);
	draw.translate(0, -0.5);
	draw.quad();
	draw.load();
}
void line(real x1, real y1, real x2, real y2, real width) {
	line(vec2(x1, y1), vec2(x2, y2), width);
}

void rect(real x1, real y1, real x2, real y2) {
	draw.save();
	draw.translate(x1, y1);
	draw.scale(x2 - x1, y2 - y1);
	draw.quad();
	draw.load();
}
void rect(vec2 p1, vec2 p2) {
	rect(p1.x, p1.y, p2.x, p2.y);
}

void frame(real x1, real y1, real x2, real y2, real width) {
	draw.line(x1, y1, x2, y1, width);
	draw.line(x2, y1, x2, y2, width);
	draw.line(x2, y2, x1, y2, width);
	draw.line(x1, y2, x1, y1, width);
}
void frame(vec2 p1, vec2 p2, real width) {
	frame(p1.x, p1.y, p2.x, p2.y, width);
}
