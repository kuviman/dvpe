import vpe;
import vpl;

Texture boxTex;

auto createBoxTexture() {
	enum n = 16;
	auto tex = new Texture(n, n);
	draw.beginTexture(tex);
	draw.clear(0, 0, 0);
	draw.translate(-1, -1);
	draw.scale(cast(real) 2 / n);
	foreach (i; 0..n) {
		foreach (j; 0..n) {
			draw.color(Color.fromHSV(random!real(0.5, 0.6), random!real(0.5, 0.7), 0.8));
			if (i == 0 || i == n - 1 || j == 0 || j == n - 1)
				draw.color(0, 0, 0);
			draw.quad();
			draw.translate(1, 0);
		}
		draw.translate(-n, 1);
	}
	draw.endTexture();
	return tex;
}

void renderBox() {
	draw.save();
	boxTex.render();
	draw.translate(0, 0, 1);
	boxTex.render();
	draw.load();

	draw.save();
	draw.multMatrix(mat4.createRotation(vec3(1, 0, 0), PI / 2));
	boxTex.render();
	draw.load();
	draw.save();
	draw.translate(0, 1, 0);
	draw.multMatrix(mat4.createRotation(vec3(1, 0, 0), PI / 2));
	boxTex.render();
	draw.load();

	draw.save();
	draw.multMatrix(mat4.createRotation(vec3(0, -1, 0), PI / 2));
	boxTex.render();
	draw.load();
	draw.save();
	draw.translate(1, 0, 0);
	draw.multMatrix(mat4.createRotation(vec3(0, -1, 0), PI / 2));
	boxTex.render();
	draw.load();
}

void main() {
	display.title = "VPE Box3D Example";
	display.setMode(400, 400, false);
	Texture tex = null;
	boxTex = createBoxTexture();
	Shader vig = new Shader(import("vignetting.glsl"));
	auto mat = mat4.identity;
	mainloop: while (!gotEvent!Quit) {
		if (gotEvent!KeyDown(Key.Escape)) break;

		foreach (e; getEvents!Scroll) {
			enum sens = 0.1;
			real ax = -e.dx * sens;
			real ay = e.dy * sens;
			mat = mat4.createRotation(0, 1, 0, ax) *
				mat4.createRotation(1, 0, 0, ay) * mat;
		}

		enum px = 3;
		if (tex is null || tex.size != draw.size / px) {
			vec2i sz = draw.size / px;
			sz.x = max(1, sz.x);
			sz.y = max(1, sz.y);
			tex = new Texture(sz.x, sz.y);
		}

		draw.beginTexture(tex);
		draw.save();

		draw.view(1);

		draw.clear(0.8, 0.8, 1);

		draw.save();
		draw.translate(-1, -1);
		draw.scale(2);
		draw.color(0, 0, 0, 1);
		vig.renderQuad();
		draw.load();

		draw.scale(0.4);
		draw.multMatrix(mat);
		draw.translate(-0.5, -0.5, -0.5);
		draw.depthTesting = true;
		renderBox();
		draw.depthTesting = false;

		draw.load();
		draw.endTexture();

		draw.clear(0, 0, 0);
		draw.save();
		draw.translate(-1, -1);
		draw.scale(2);
		tex.render();
		draw.load();

		display.flip();
	}
}
