import vpe;
import vpl;

void main() {
	auto clock = new Clock();
	while (clock.currentTime < 2)
		display.flip();
}
