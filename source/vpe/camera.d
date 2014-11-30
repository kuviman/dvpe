module vpe.camera;

import vpe.internal;

class Camera {
	real fov;
	vec2 position = vec2(0, 0);
	this(real fov) {
		this.fov = fov;
	}
	void apply() {
		draw.view(fov);
		draw.origin(position);
	}
	vec2 mousepos() {
		vec2 pos = mouse.position - vec2(draw.size) / 2;
		pos = pos * (fov / draw.height);
		return position + pos;
	}
}
