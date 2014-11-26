module vpe.draw.text;

import vpe.internal;

enum FontType {
	Default,
	Mono
}

/// Default rendering font
private template _font(alias fontType = FontType.Default) {
	static if (is(typeof(fontType) == FontType))
		Font _font;
	else static if (is(typeof(fontType) : string)) {
		static if (fontType == "default")
			alias _font!(FontType.Default) _font;
		else static if (fontType == "mono")
			alias _font!(FontType.Mono) _font;
		else static assert(false);
	} else static assert(false);
}

Font font(alias fontType = FontType.Default)() { return _font!fontType; }
void font(alias fontType = FontType.Default)(Font value) { _font!fontType = value; }

/// Measure text using default font
auto measureText(alias fontType = FontType.Default)(string text) { return font!fontType.measure(text); }

/**
 * Render text using default font
 * Params:
 *	text = Text to render
 *	ax = horizontal alignment
 *	ay = vertical alignment
 */
void text(alias fontType = FontType.Default)(string text, real ax, real ay = 0) {
	font!fontType.render(text, ax, ay);
}
/// ditto
void text(alias fontType = FontType.Default)(string text) {
	font!fontType.render(text);
}
