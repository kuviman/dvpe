import vpe;
import vpl;

void main() {
	auto clock = new Clock();
	while (clock.currentTime < 2) {
		draw.clear(Color(0.8, 0.8, 1));
		draw.quad();
		display.flip();
	}
}
