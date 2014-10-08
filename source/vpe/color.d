module vpe.color;

import vpe.internal;

struct Color {
	vec4 vec;
	alias vec this;

	this(real r, real g, real b, real a = 1) {
		vec = vec4(r, g, b, a);
	}

	ref r() { return vec.x; }
	ref g() { return vec.y; }
	ref b() { return vec.z; }
	ref a() { return vec.w; }

	static Color fromHSV(real h, real s, real v, real a = 1) {
		h -= floor(h);
		real r, g, b;
		real f = h * 6 - floor(h * 6);
		real p = v * (1 - s);
		real q = v * (1 - f * s);
		real t = v * (1 - (1 - f) * s);
		if (h * 6 < 1) { r = v; g = t; b = p; }
		else if (h * 6 < 2) { r = q; g = v; b = p; }
		else if (h * 6 < 3) { r = p; g = v; b = t; }
		else if (h * 6 < 4) { r = p; g = q; b = v; }
		else if (h * 6 < 5) { r = t; g = p; b = v; }
		else { r = v; g = p; b = q; }
		return Color(r, g, b, a);
	}
}
