module vpe.font;

public {
	import vpe.font.texture;
	import vpe.font.ttf;
}

import vpe.internal;

interface Font {
	real measure(string text);
	void render(string text);

	final void render(string text, real ax, real ay = 0) {
		draw.save();
		draw.translate(-ax * measure(text), -ay);
		render(text);
		draw.load();
	}
	final void render(string text, vec2 agn) {
		render(text, agn.x, agn.y);
	}
}
