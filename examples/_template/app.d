import vpe;
import vpl;

void main() {
	auto clock = new Clock();
	real angle = 0;
	mainloop: while (!gotEvent!Quit) {
		if (gotEvent!KeyDown(Key.Escape)) break;
		if (gotEvent!KeyDown(Key.Space)) angle = 0;
		foreach (T; EventTypes) {
			foreach (e; getEvents!T) {
				log("%s", e);
				logIndent();
				static if (is(T:MouseButtonDown) || is(T:MouseButtonUp)) {
					auto pos = mouse.position;
					log("mouse pos = %s %s", pos.x, pos.y);
				}
				logUnindent();
			}
		}
		draw.clear(Color(0.8, 0.8, 1));

		draw.save();
		draw.color(clock.currentTime % 1, 0, 0);
		draw.rotate(angle);
		draw.scale(0.1);
		draw.translate(-0.5, -0.5);
		draw.quad();
		draw.load();

		display.flip();

		angle += clock.tick();
	}
}
