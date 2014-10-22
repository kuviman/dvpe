/// vpe.font submodule
module vpe.font.texture;

import vpe.internal;

/// Texture font
class TextureFont : Font {
	/// Create a texture font from given texture
	this(Texture texture) {
		this.texture = texture;
	}
	real measure(string text) {
		return text.length;
	}
	void render(string text) {
		draw.save();
		foreach (char c; text) {
			int idx = c;
			auto i = idx / 16;
			auto j = idx % 16;
			texture.renderSub(vec2(j, 16 - 1 - i) / 16, vec2(1, 1) / 16);
			draw.translate(1, 0);
		}
		draw.load();
	}

	private Texture texture;
}
