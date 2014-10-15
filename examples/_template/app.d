import vpe;
import vpl;

void main() {
	display.title = "VPE Example Template";

	string[] lines;

	mainloop: while (!gotEvent!Quit) {
		if (gotEvent!KeyDown(Key.Escape)) break;
		foreach (T; EventTypes) {
			foreach (e; getEvents!T) {
				lines ~= e.to!string;
			}
		}
		size_t MAX_LINES = (draw.height - 40) / 16;
		if (lines.length > MAX_LINES) lines = lines[$ - MAX_LINES .. $];

		draw.clear(0.8, 0.8, 1);

		draw.save();
		draw.view(draw.height);
		draw.translate(-draw.width / 2, -draw.height / 2);

		draw.color(0, 0, 0);

		draw.translate(20, 20);
		draw.scale(16);
		foreach_reverse (line; lines) {
			draw.text(line);
			draw.translate(0, 1);
		}

		draw.load();

		display.flip();
	}
}
