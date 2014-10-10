module vpe.texture;

import vpe.internal;

class Texture {
	this() { tex = new RawTexture(); }
	this(int width, int height) {
		this();
		_width = width; _height = height;
		glBindTexture(GL_TEXTURE_2D, tex);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
		glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_BGRA, GL_UNSIGNED_BYTE, cast(const(void)*)null);
	}
	auto width() { return _width; }
	auto height() { return _height; }

	auto size() { return vec2i(width, height); }

	void render() {
		alias textureShader shader;
		shader.setTexture("texture", this);
		shader.renderQuad();
	}
private:
	package RawTexture tex;
	int _width, _height;
}
