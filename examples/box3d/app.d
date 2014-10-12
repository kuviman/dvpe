import vpe;
import vpl;

Texture boxTex;

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
	auto font = new TextureFont(Texture.loadFromMem(importBinary!"font.png"));
	auto font2 = TTFFont.loadFromMem(importBinary!"font.ttf", 12);
	display.title = "VPE Box3D Example";
	display.setMode(400, 400, false);
	boxTex = Texture.loadFromMem(importBinary!"box.jpg");
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

		draw.save();
		draw.view(1);
		draw.clear(0.8, 0.8, 1);

		draw.save();
		draw.translate(-1, -1);
		draw.scale(2);
		draw.color(0, 0, 0, 1);
		vig.render();
		draw.load();

		draw.scale(0.4);
		draw.multMatrix(mat);
		draw.translate(-0.5, -0.5, -0.5);
		draw.depthTesting = true;
		renderBox();
		draw.depthTesting = false;

		draw.load();

		draw.save();
		draw.view(draw.height);
		auto pos = vec2(10, 10);
		draw.translate(-draw.width / 2 + pos.x, -draw.height / 2 + pos.y);
		draw.scale(28);
		font2.render(display.title);
		draw.load();

		display.flip();
	}
}
