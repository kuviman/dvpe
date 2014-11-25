import vpe;
import vpl;

Texture boxTex;
Shader vig;
static this() {
	boxTex = Texture.loadFromMem(importBinary!"box.jpg");
	vig = new Shader(import("vignetting.glsl"));
}

void renderBox() {
	foreach (coord; 0..3) {
		foreach (val; 0..2) {
			vec3[] pts;
			foreach (mask; RangeTuple!(1 << 3)) {
				if (((mask >> coord) & 1) != val) continue;
				pts ~= vec3(mask.getBit(0), mask.getBit(1), mask.getBit(2));
			}
			draw.save();
			draw.multMatrix(mat4.fromOrts(pts[1] - pts[0], pts[2] - pts[0], vec3(0, 0, 0), pts[0]));
			boxTex.render();
			draw.load();
		}
	}
}

class Box3D : State {
	this() {
		bind(KeyDown(Key.Escape), &close);
	}

	mat4 mat = mat4.identity;
	vec2 lastMpos = vec2(0, 0);
	override void update(real dt) {
		vec2 curPos = mouse.position;
		if (MouseButton.Left.pressed) {
			enum sens = 0.01;
			real ax = (curPos - lastMpos).x * sens;
			real ay = -(curPos - lastMpos).y * sens;
			mat = mat4.createRotation(0, 1, 0, ax) *
				mat4.createRotation(1, 0, 0, ay) * mat;
		}
		lastMpos = curPos;
	}

	override void render() {
		draw.clear(0.8, 0.8, 1);

		draw.save();
		draw.translate(-1, -1);
		draw.scale(2);
		draw.color(0, 0, 0, 1);
		vig.render();
		draw.load();

		draw.depthTesting = true;
		draw.save();
		draw.perspectiveView(PI / 4);
		draw.translate(0, 0, -3);
		draw.multMatrix(mat);
		draw.translate(-0.5, -0.5, -0.5);
		renderBox();
		draw.load();
		draw.depthTesting = false;
	}
}

void main() {
	display.title = "VPE Box3D Example";
	display.setMode(400, 400, false);
	new Box3D().run();
}
