module vpe.font.ttf;

import vpe.internal;

class TTFFont : Font {
	private this() {}

	real measure(string text) {
		int w, h;
		TTF_SizeText(rfont, text.toStringz, &w, &h);
		return cast(real) w / h;
	}
	void render(string text) {
		SDL_Surface* surface = TTF_RenderText_Solid(rfont, text.toStringz, SDL_Color(0xff, 0xff, 0xff));
		auto tex = textureFromSurface(surface);
		draw.save();
		draw.scale(cast(real) tex.width / tex.height, 1);
		tex.render();
		draw.load();
		SDL_FreeSurface(surface);
	}

	static TTFFont load(string path, int ptsize) {
		auto res = new TTFFont();
		res.rfont = new RawTTF(TTF_OpenFont(path.toStringz, ptsize));
		return res;
	}
	static TTFFont loadFromMem(const byte[] data, int ptsize) {
		auto res = new TTFFont();
		res.rfont = new RawTTF(TTF_OpenFontRW(SDL_RWFromConstMem(
			data.ptr, cast(int)data.length), 1, ptsize));
		return res;
	}
private:
	RawTTF rfont;
}
