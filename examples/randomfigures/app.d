import vpe;
import vpl;

class Figure {
	vec2[] points;
	vec2 pos;
	Color color;
	real angle = 0, w;

	this(vec2 pos) {
		this.pos = pos;
		points.length = randomInc!size_t(3, 8);
		auto size = random!real(20, 50);
		foreach (i, ref p; points) {
			auto phi = i * 2 * PI / points.length;
			p = vec2(size, 0).rotate(phi);
		}
		color = Color.fromHSV(random!real(0, 1), 1, 1, 0.5);
		w = random!real(-1, 1);
	}

	void update(real dt) {
		angle += w * dt;
	}

	void render() {
		draw.save();

		draw.translate(pos.x, pos.y);
		draw.rotate(angle);

		draw.color = color;
		draw.polygon(points);
		draw.color = Color.Black;
		draw.polyline(points, 3, true);

		draw.load();
	}
}

class RFS : State {
	Figure[] figures;

	this() {
		bind(KeyDown(Key.Escape), &close);
		bind(MouseButtonDown(MouseButton.Left), { newFigure(mouse.position); });
	}

	void newFigure(vec2 pos) { figures ~= new Figure(pos); }
	void newFigure() { newFigure(vec2(random!real(0, draw.width), random!real(0, draw.height))); }

	override void update(real dt) {
		if (Key.Space.pressed) newFigure();
		foreach (f; figures)
			f.update(dt);
	}

	override void render() {
		draw.save();
		draw.plainview();

		draw.clear(0.8, 0.8, 1);

		foreach (f; figures)
			f.render();

		draw.save();
		draw.translate(10, 10);
		draw.scale(20);
		auto text = mixin(subst!"NumFigures: $(figures.length); FPS: $(display.FPS.to!int)");
		draw.color(1, 1, 1, 0.75);
		draw.rect(0, 0, draw.measureText(text), 1);
		draw.color(Color.Black);
		draw.text(text);
		draw.load();

		draw.load();
	}
}

void main() {
	display.title = "VPE Random Figures Example";
	new RFS().run();
}
