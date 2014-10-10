import vpe;
import vpl;

void main() {
	auto clock = new Clock();
	real angle = 0;

	vec2 pos = vec2(0, 0);

	auto tex = new Texture(100, 100);

	mainloop: while (!gotEvent!Quit) {
		if (gotEvent!KeyDown(Key.Escape)) break;
		if (gotEvent!KeyDown(Key.Space)) angle = 0;
		foreach (T; EventTypes) {
			foreach (e; getEvents!T) {
				log("%s", e);
				logIndent();
				static if (is(T:MouseButtonDown) || is(T:MouseButtonUp)) {
					auto mpos = mouse.position;
					log("mouse pos = %s %s", mpos.x, mpos.y);
				}
				logUnindent();
			}
		}

		foreach (e; getEvents!Scroll)
			pos = pos + e.dv / 10;

		draw.beginArea(160, 120, 320, 240);

		draw.clear(Color(0.8, 0.8, 1));

		draw.save();
		draw.translate(pos.x, pos.y);
		draw.color(clock.currentTime % 1, 0, 0);
		draw.rotate(angle);
		draw.scale(0.1);
		draw.translate(-0.5, -0.5);
		//draw.quad();
		tex.render();
		draw.load();

		draw.endArea();

		display.flip();

		int sign = 0;
		if (Key.Left.pressed) sign++;
		if (Key.Right.pressed) sign--;
		angle += clock.tick * sign;
	}
}
