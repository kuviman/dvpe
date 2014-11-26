import vpe;
void main() {
	display.title = "Hello, world!";
	while (!gotEvent!Quit) {
		draw.clear(Color.White);
		draw.save();
		draw.plainview();
		draw.color(Color.Black);
		draw.translate(draw.width / 2, draw.height / 2);
		draw.scale(32);
		draw.text("Hello, world!", 0.5);
		draw.load();
		display.flip();
	}
}
