/**
 * VPE game engine
 *
 * Examples:
 *	Render blue background
 * ---
 *	import vpe;
 *
 *	void main() {
 *		while (!gotEvent!Quit) {
 *			draw.clear(Color.Blue);
 *			display.flip();
 *		}
 *	}
 * ---
 *
 * Copyright: © 2014 kuviman
 * License: MIT
 * Authors: kuviman
 */
module vpe;

public {
	import display = vpe.display;
	import draw = vpe.draw;
	import vpe.clock;
	import vpe.color;
	import vpe.shader;
	import vpe.input;
	import vpe.events;
	import vpe.texture;
	import vpe.font;
	import vpe.state;

	import vpe.draw : BlendMode;
	import vpe.draw.text : FontType;
}

import vpe.internal;

static this() {
	initalizeVPE();
}
static ~this() {
	terminateVPE();
}
