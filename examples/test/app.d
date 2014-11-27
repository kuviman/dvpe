import vpe;
import vpl;

void main() {
	log("Set title");
	display.title = "VPE Test";
	log("Go fullscreen");
	display.fullscreen = true;
	log("Go windowed");
	display.fullscreen = false;
	log("Creating a texture");
	auto tex = new Texture(100, 100);
	log("Start rendering to texture");
	draw.beginTexture(tex);
	log("Setup view");
	draw.plainview();
	log("Draw a line");
	draw.color = Color.Blue;
	draw.line(vec2(0, 0), vec2(tex.size), 1);
	log("End rendering to texture");
	draw.endTexture();
	log("Start rendering to area");
	draw.beginArea(0, 0, 1, 1);
	log("Render the texture");
	tex.render();
	log("End rendering to area");
	draw.endArea();
	log("Render text");
	draw.text("Hello");
}
