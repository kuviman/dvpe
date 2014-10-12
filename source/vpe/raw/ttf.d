module vpe.raw.ttf;

import vpe.internal;

class RawTTF {
	this(TTF_Font* font) {
		this.font = font;
	}
	~this() {
		if (vpeTerminated) return;
		freeQ.push(font);
	}
	alias font this;
	TTF_Font* font;
}

auto freeQ = new shared SynQueue!(TTF_Font*)();
void freeTTFs() {
	TTF_Font* font;
	while (freeQ.pop(font)) {
		TTF_CloseFont(font);
	}
}
