import vpe;
import vpl;

class Player {
	vec2 size = vec2(5, 30);
	vec2 pos = vec2(0, 0);

	Color color = Color.White;

	real speed = 300;
	private real direction = 0, needDirection = 0;

	void move(real dir) {
		needDirection = clamp(dir, -1, 1);
	}

	real accel = 10;
	void update(real dt) {
		direction += (needDirection - direction) * clamp(dt * accel, 0, 1);
		pos.y += direction * speed * dt;
	}

	void render() {
		draw.save();
		draw.color(color);
		vec2 dv = size;
		dv.y -= size.x;
		draw.rect(pos - dv, pos + dv);
		dv.x = 0;
		draw.circle(pos - dv, size.x);
		draw.circle(pos + dv, size.x);
		draw.load();
	}

	abstract void think(World);
}

class EmptyPlayer : Player {
	override void think(World world) {}
}

class AIPlayer : Player {
	override void think(World world) {
		if (nextThink > 0) return;
		Ball ball = null;
		if (world.balls.length > 0)
			ball = world.balls[0];
		if (ball is null){
			move(0);
			return;
		}
		// ball.pos.x + ball.vel.x * t = pos.x
		if (ball.vel.x == 0) return;
		real tox = pos.x;
		if (ball.vel.x.sign != (pos.x - ball.pos.x).sign)
			tox = (ball.pos.x - pos.x).sign * world.size.x * 3;
		auto t = (tox - ball.pos.x) / ball.vel.x;
		auto y = ball.pos.y + ball.vel.y * t;
		while (abs(y) > world.size.y) {
			if (y < -world.size.y)
				y = -world.size.y + (-world.size.y - y);
			else
				y = world.size.y - (y - world.size.y);
		}
		this.targetY = y;
		move((y - pos.y) / 30);
		nextThink = random!real(0.1, 0.2);
	}
	real targetY = 0;
	real nextThink = 0;
	override void update(real dt) {
		super.update(dt);
		nextThink -= dt;
	}
	override void render() {
		super.render();
		draw.save();
		draw.color(1, 0, 0, 0.2);
		draw.circle(pos.x, targetY, size.x * 1.5);
		draw.load();
	}
}

class ControlledPlayer : Player {
	Key keyDown, keyUp;
	this(Key keyDown, Key keyUp) {
		this.keyDown = keyDown;
		this.keyUp = keyUp;
	}
	override void think(World world) {
		real dir = 0;
		if (keyDown.pressed) dir -= 1;
		if (keyUp.pressed) dir += 1;
		move(dir);
	}
}

class Ball {
	vec2 pos = vec2(0, 0);
	real size = 6;

	Color color = Color.White;

	vec2 vel;
	this(real speed = 400) {
		this.setSpeed = speed;
		vel = vec2(speed, 0).rotate(random!real(-PI / 4, PI / 4));
		if (random!bool()) vel = -vel;
	}

	real setSpeed;

	void update(real dt) {
		speed = clamp(speed + accel * dt, 0, 1);
		if (abs(vel.y) > abs(vel.x)) {
			vel.x += fixX * vel.x.sign * dt;
			vel = vel.unit * setSpeed;
		}
		pos += vel * speed * dt;
	}
	real fixX = 300;
	real speed = 0;
	real accel = 0.5;

	void render() {
		draw.save();
		draw.color(color);
		//draw.rect(pos - vec2(size, size), pos + vec2(size, size));
		draw.circle(pos, size);
		draw.load();
	}
}

class World {
	Player[] players;
	Ball[] balls;

	vec2 size = vec2(180, 150);
	real borderSize = 1;
	Color borderColor = Color.White;

	void update(real dt) {
		foreach (player; players) {
			player.think(this);
			player.update(dt);
			player.pos.y = clamp(player.pos.y, -size.y + player.size.y, size.y - player.size.y);
		}
		foreach (ball; balls) {
			ball.update(dt);
			if (ball.pos.x.abs > size.x - ball.size) {
				balls = [new Ball()];
				break;
				//ball.pos.x = (size.x - ball.size) * ball.pos.x.sign;
				//ball.vel.x = -ball.vel.x;
			}
			if (ball.pos.y.abs > size.y - ball.size) {
				ball.pos.y = (size.y - ball.size) * ball.pos.y.sign;
				ball.vel.y = -ball.vel.y;
			}
			foreach (player; players) {
				if (abs(ball.pos.y - player.pos.y) > ball.size + player.size.y)
					continue;
				if (abs(ball.pos.x - player.pos.x) < ball.size + player.size.x) {
					ball.pos.x = player.pos.x + (ball.size + player.size.x) * (ball.pos.x - player.pos.x).sign;
					ball.vel.x = -ball.vel.x;
					enum ang = 0.3;
					ball.vel = ball.vel.rotate(random!real(-ang, ang));
				}
			}
		}
	}
	void render() {
		draw.save();
		auto col = borderColor;
		col.a *= 0.5;
		draw.color(col);
		draw.dashedLine(0, -size.y, 0, size.y, borderSize);
		draw.color(borderColor);
		draw.frame(-size, size, borderSize);
		draw.load();

		foreach (player; players)
			player.render();
		foreach (ball; balls)
			ball.render();
	}
}

class Pong : State {
	Color backgroundColor = Color.Black;

	World world;
	this() {
		world = new World();
		enum playersPos = 0.9;
		auto setPos(Player player, real x) {
			player.pos.x = x;
			return player;
		}
		auto leftPlayer = new AIPlayer();
		auto rightPlayer = new AIPlayer();
		//auto rightPlayer = new ControlledPlayer(Key.Down, Key.Up);
		world.players ~= setPos(leftPlayer, -world.size.x * playersPos);
		world.players ~= setPos(rightPlayer, +world.size.x * playersPos);
		world.balls ~= new Ball();
	}
	override void update(real dt) {
		world.update(dt);
	}
	override void render() {
		draw.clear(backgroundColor);
		draw.save();
		draw.view(2 * world.size.y + 50);
		world.render();
		draw.load();
	}
	override void keyDown(Key key) { if (key == Key.Escape) close(); }
}

void main() {
	display.title = "VPE Pong Example";
	new Pong().run();
}
