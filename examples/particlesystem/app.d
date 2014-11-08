import vpe;
import vpl;

class Particle {
	vec3 pos, vel;
	this() {
		pos = vec3(0, 0, 0);
		vel = vec3(random!real(-1, 1), random!real(-1, 1), 20);
		color = Color.fromHSV(random!real(0, 1), 0.5, 1, 0.1);
	}
	void update(real dt) {
		life -= dt / 10;
		vel.z -= 9.8 * dt;
		pos += vel * dt;
		if (pos.z < 0) {
			size *= 0.8;
			pos.z = 0;
			vel.z = -vel.z * random!real(0.2, 0.3);
		}
	}

	real life = 1;
	real size = 1;

	Color color;

	void render() {
		draw.save();
		draw.color = color;
		draw.translate(pos);
		draw.scale(size);
		draw.billboard();
		draw.circle(0, 0, 1);
		draw.load();
	}
}

class ParticleSystem {
	enum MAX_LEN = 300;
	Particle[] ps;
	real nextTime = 1;
	void update(real dt) {
		nextTime -= 40 * dt;
		while (nextTime < 0) {
			nextTime += 1;
			ps ~= new Particle();
		}
		while ((ps.length > 0 && ps[0].life < 0) || ps.length > MAX_LEN) {
			ps = ps[1..$].dup;
		}
		foreach (p; ps)
			p.update(dt);
	}
	void render() {
		draw.save();
		//draw.scale(0.5);
		foreach (p; ps)
			p.render();
		draw.load();
		draw.save();
		draw.color(0.1, 0.1, 0.1, 0.1);
		draw.circle(0, 0, 5);
		draw.load();
	}
}

void main() {
	display.title = "VPE ParticleSystem Example";

	auto system = new ParticleSystem();

	draw.blendMode = BlendMode.AddAlpha;

	auto mat = mat4.identity;
	auto clock = new Clock();
	while (!gotEvent!Quit) {
		if (gotEvent!KeyDown(Key.Escape))
			break;

		foreach (e; getEvents!Scroll) {
			enum sens = 0.1;
			real ax = e.dx * sens;
			real ay = -e.dy * sens;
			mat = mat4.createRotation(0, 1, 0, ax) *
				mat4.createRotation(1, 0, 0, ay) * mat;
		}

		system.update(clock.tick());
		draw.clear(Color.Black);
		draw.save();
		draw.perspectiveView(PI / 6);
		draw.translate(0, 0, -50);
		draw.multMatrix(mat);
		system.render();
		draw.load();

		draw.save();
		draw.view(draw.height);
		draw.translate(-draw.width / 2.0, -draw.height / 2.0);
		draw.translate(10, 10);
		draw.scale(40);
		draw.text("FPS : %s".format(clock.FPS.to!int));
		draw.load();

		display.flip();
	}
}
