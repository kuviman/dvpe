module vpe.texture.internal;

import vpe.internal;

auto getRawTexture(Texture tex) { return tex.tex; }
auto textureFromSurface(SDL_Surface* surface) {
	auto tex = new Texture();
	tex.setSDL_Surface(surface);
	return tex;
}

void free(Texture tex) {
	tex.tex.free();
	tex.tex = null;
}
