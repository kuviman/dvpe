/**
 * Font
 *
 * Copyright: © 2014 kuviman
 * License: MIT
 * Authors: kuviman
 */
module vpe.font;

public {
	import vpe.font.texture;
	import vpe.font.ttf;
}

import vpe.internal;

/// Font interface
interface Font {
	/// Measure the text
	real measure(string text);
	/// Render the text
	void render(string text);

	/// ditto
	final void render(string text, real ax, real ay = 0) {
		draw.save();
		draw.translate(-ax * measure(text), -ay);
		render(text);
		draw.load();
	}
	/// ditto
	final void render(string text, vec2 agn) {
		render(text, agn.x, agn.y);
	}
}
