/**
 * Input manipulation
 *
 * Copyright: © 2014 kuviman
 * License: MIT
 * Authors: kuviman
 */
module vpe.input;

public {
	import vpe.input.key;
	import vpe.input.mousebutton;
	import vpe.input.keyboard;

	import mouse = vpe.input.mouse;
}

import vpe.input.mouse : pressed;
alias vpe.input.keyboard.pressed pressed;
