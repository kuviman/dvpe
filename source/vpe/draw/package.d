module vpe.draw;

public {
	import vpe.draw.transform;
	import vpe.draw.area;
}

import vpe.internal;

void clear(real r, real g, real b, real a = 1) {
	glClearColor(r, g, b, a);
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
}
void clear(Color color) { clear(color.r, color.g, color.b, color.a); }

void quad() {
	colorShader.renderQuad();
}

void color(Color color) {
	renderState.color = color;
}
void color(real r, real g, real b, real a = 1) {
	renderState.color = Color(r, g, b, a);
}

void save() { saveRenderState(); }
void load() { loadRenderState(); }

void beginTexture(Texture texture) { beginTarget(texture); }
void endTexture() { endTarget(); }

vec2i size() {
	if (renderAreaSizeStack.length == 0) {
		if (currentTarget is null)
			return display.size;
		return currentTarget.size;
	}
	return renderAreaSizeStack[$ - 1];
}

Font font;

auto measureText(string text) { return font.measure(text); }
void text(string text) {
	font.render(text);
}

auto width() { return size.x; }
auto height() { return size.y; }
auto aspect() { return cast(real) width / height; }

private bool _depthTesting = false;
bool depthTesting() { return _depthTesting; }
void depthTesting(bool value) {
	_depthTesting = value;
	if (value) glEnable(GL_DEPTH_TEST);
	else glDisable(GL_DEPTH_TEST);
}
