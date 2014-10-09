import vpe;
import vpl;

void main() {
	auto clock = new Clock();
	while (clock.currentTime < 2) {
		draw.clear(Color(0.8, 0.8, 1));

		draw.save();
		draw.color(clock.currentTime / 2, 0, 0);
		draw.rotate(clock.currentTime);
		draw.scale(0.1);
		draw.translate(-0.5, -0.5);
		draw.quad();
		draw.load();

		display.flip();
	}
}
