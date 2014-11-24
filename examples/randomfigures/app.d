import vpe;
import vpl;

class Figure {
	vec2[] points;
	vec2 pos; Color color;
	real angle = 0, w;

	this(vec2 pos) {
		this.pos = pos;

		auto n = randomInc!int(3, 8);
		points.length = n;
		auto s = random!real(20, 50);
		foreach (i, ref p; points) {
			auto phi = i * 2 * PI / n;
			p = vec2(s, 0).rotate(phi);
		}
		color = Color.fromHSV(random!real(0, 1), 1, 1, 0.5);
		w = random!real(-1, 1);
	}

	void render() {
		draw.save();
		draw.color(color);
		draw.translate(pos.x, pos.y);
		draw.rotate(angle);

		draw.polygon(points);
		draw.color(Color.Black);
		foreach (i; 0..points.length) {
			auto j = (i + 1) % points.length;
			draw.line(points[i], points[j], 3);
		}

		draw.load();
	}

	void update(real dt) {
		angle += w * dt;
	}
}

void main() {
	display.title = "VPE Random Figures Example";

	Figure[] figures;

	auto clock = new Clock();
	while (!gotEvent!Quit) {
		if (gotEvent!KeyDown(Key.Escape)) break;

		if (gotEvent!MouseButtonDown(MouseButton.Left))
			figures ~= new Figure(mouse.position);
		if (Key.Space.pressed)
			figures ~= new Figure(vec2(
				random!real(0, draw.width),
				random!real(0, draw.height)));

		draw.clear(0.8, 0.8, 1);
		draw.save();
		draw.view(draw.height);
		draw.translate(-draw.width / 2, -draw.height / 2);

		foreach (f; figures)
			f.render();

		draw.save();
		draw.translate(10, 10);
		draw.scale(20);
		draw.color(1, 1, 1, 0.75);
		auto text = mixin(subst!"NumFigures: $(figures.length); FPS: $(clock.FPS.to!int)");
		//auto text = "NumFigures: %s; FPS: %s".format(figures.length, clock.FPS.to!int);
		draw.rect(0, 0, draw.measureText(text), 1);
		draw.color(Color.Black);
		draw.text(text);
		draw.load();

		draw.load();

		display.flip();
		auto dt = clock.tick();
		foreach (f; figures)
			f.update(dt);
	}
}
