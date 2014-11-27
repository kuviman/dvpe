import vpe;
import vpl;

class EventList : State {
	static class Line {
		string text;
		vec2 pos = vec2(0, 0);
		real size = 32;
		real life = 1;

		this(string text) {
			this.text = text;
		}

		void render() {
			draw.save();
			draw.translate(pos);
			draw.color(0, 0, 0, life * (1 - cast(real) (size - 16) / 16));
			draw.scale(size);
			draw.text(text);
			draw.load();
		}
	}

	Line[] lines;

	override void update(real dt) {
		foreach (T; EventTypes) {
			foreach (e; getEvents!T) {
				lines ~= new Line(e.to!string);
			}
		}
		size_t MAX_LINES = (draw.height - 100) / 16;
		foreach (line; lines[0 .. $ - min($, MAX_LINES)]) {
			line.life -= dt * 5;
		}
		lines = lines.filter!(line => line.life > 0).array;

		foreach (i, line; lines) {
			vec2 needPos = vec2(20, 20 + (lines.length - 1 - i) * 16);
			line.pos += (needPos - line.pos) * clamp(dt * 30, 0, 1);
			line.size += (16 - line.size) * clamp(dt * 10, 0, 1);
		}
	}

	override void render() {
		draw.clear(0.8, 0.8, 1);

		draw.save();
		draw.plainview();

		foreach (line; lines)
			line.render();

		draw.translate(draw.width -20, 20);
		draw.scale(16);
		draw.color(Color.Black);
		draw.text!"mono"("FPS : %s".format(display.FPS.to!int), 1);

		draw.load();
	}
}

void main() {
	display.title = "VPE EventList Example";
	new EventList().run();
}
