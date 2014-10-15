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

void rect(real x1, real y1, real x2, real y2) {
	draw.save();
	draw.translate(x1, y1);
	draw.scale(x2 - x1, y2 - y1);
	draw.quad();
	draw.load();
}
