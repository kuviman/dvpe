import vpe;
import vpl;

void main() {
	display.title = "VPE Example Template";
	mainloop: while (!gotEvent!Quit) {
		if (gotEvent!KeyDown(Key.Escape)) break;
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
		draw.clear(0.8, 0.8, 1);
		display.flip();
	}
}
