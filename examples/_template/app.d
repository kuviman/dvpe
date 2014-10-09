import vpe;
import vpl;

void main() {
	auto clock = new Clock();
	while (clock.currentTime < 2) {
		draw.clear(Color(0.8, 0.8, 1));
		draw.modelMatrix = mat4.createTranslation(0.5, -0.5, 0);
		draw.color(clock.currentTime / 2, 0, 0);
		draw.quad();
		display.flip();
	}
}
