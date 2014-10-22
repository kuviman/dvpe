/// vpe.font submodule
module vpe.font.ttf;

import vpe.internal;

/// TTF font
class TTFFont : Font {

	/// TTF font style
	enum Style {
		/// Normal
		Normal = TTF_STYLE_NORMAL,
		/// Bold
		Bold = TTF_STYLE_BOLD,
		/// Italic
		Italic = TTF_STYLE_ITALIC,
		/// Underline
		Underline = TTF_STYLE_UNDERLINE,
		/// Strikethrough
		Strikethrough = TTF_STYLE_STRIKETHROUGH
	}

	private this() {}

	real measure(string text) {
		int w, h;
		TTF_SizeText(rfont, text.toStringz, &w, &h);
		return cast(real) w / h;
	}
	void render(string text) {
		SDL_Surface* surface = smooth ?
			TTF_RenderText_Blended(rfont, text.toStringz, SDL_Color(0xff, 0xff, 0xff)):
			TTF_RenderText_Solid(rfont, text.toStringz, SDL_Color(0xff, 0xff, 0xff));
		auto tex = textureFromSurface(surface);
		tex.smooth = _smooth;
		draw.save();
		draw.scale(cast(real) tex.width / tex.height, 1);
		tex.render();
		draw.load();
		SDL_FreeSurface(surface);
	}

	/// Load from file
	static TTFFont load(string path, int ptsize) {
		auto res = new TTFFont();
		res.rfont = new RawTTF(TTF_OpenFont(path.toStringz, ptsize));
		return res;
	}
	/// Load from memory
	static TTFFont loadFromMem(const byte[] data, int ptsize) {
		auto res = new TTFFont();
		res.rfont = new RawTTF(TTF_OpenFontRW(SDL_RWFromConstMem(
			data.ptr, cast(int)data.length), 1, ptsize));
		return res;
	}

	/// Set font's style
	void style(Style value) {
		TTF_SetFontStyle(rfont, cast(int)value);
	}

	private bool _smooth = true;
	/// Get or set font smoothness
	bool smooth() { return _smooth; }
	/// ditto
	void smooth(bool value) {
		_smooth = value;
	}

private:
	RawTTF rfont;
}
