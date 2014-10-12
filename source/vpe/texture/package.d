module vpe.texture;

import vpe.internal;

class Texture {
	private this() {
		tex = new RawTexture();
		glBindTexture(GL_TEXTURE_2D, tex);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
	}
	this(int width, int height) {
		this();
		_width = width; _height = height;
		glBindTexture(GL_TEXTURE_2D, tex);
		glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_BGRA, GL_UNSIGNED_BYTE, cast(const(void)*)null);
	}
	auto width() { return _width; }
	auto height() { return _height; }

	auto size() { return vec2i(width, height); }

	void render() {
		alias textureShader shader;
		shader.setMat3("textureMatrix", mat3.identity);
		shader.setTexture("texture", this);
		shader.renderQuad();
	}

	void renderSub(vec2 pos, vec2 size) { renderSub(pos.x, pos.y, size.x, size.y); }
	void renderSub(real x, real y, real sizex, real sizey) {
		alias textureShader shader;
		auto mat = mat3.createTranslation(x, y) * mat3.createScale(sizex, sizey);
		shader.setMat3("textureMatrix", mat);
		shader.setTexture("texture", this);
		shader.renderQuad();
	}

	static Texture load(string path) {
		auto tex = new Texture();
		auto image = IMG_Load(path.toStringz);
		if (!image)
			throw new Exception("Could not load texture from \"" ~ path ~ "\"");
		tex.setSDL_Surface(image);
		SDL_FreeSurface(image);
		return tex;
	}

	static Texture loadFromMem(const byte[] data) {
		auto tex = new Texture();
		auto image = IMG_Load_RW(SDL_RWFromConstMem(data.ptr, cast(int)data.length), 1);
		if (!image)
			throw new Exception("Could not load texture");
		tex.setSDL_Surface(image);
		SDL_FreeSurface(image);
		return tex;
	}

private:
	package RawTexture tex;
	int _width, _height;

	void setSDL_Surface(SDL_Surface* surface) {
		glBindTexture(GL_TEXTURE_2D, tex);
		auto w = surface.w, h = surface.h;
		_width = w; _height = h;
		auto image = SDL_CreateRGBSurface(SDL_SWSURFACE, w, h, 32, 0x000000ff, 0x0000ff00, 0x00ff0000, 0xff000000);
		enforce(image, "Could not create SDL_Surface");
		SDL_BlitSurface(surface, null, image, null);
		for (int y = 0; y < h / 2; y++)
			for (int x = 0; x < w; x++)
				swap((cast(int*)image.pixels)[y * w + x],
				     (cast(int*)image.pixels)[(h - 1 - y) * w + x]);
		glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, w, h, 0, GL_RGBA,
			GL_UNSIGNED_BYTE, image.pixels);
		SDL_FreeSurface(image);
	}
}
