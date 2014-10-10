module vpe.draw.internal.target;

import vpe.internal;

void beginTarget(Texture texture) {
	endUse();
	targetStack ~= currentTarget;
	currentTarget = texture;
	use();
	saveRenderState();
	renderState = renderState.init;
}

void endTarget() {
	endUse();
	currentTarget = targetStack[$ - 1];
	targetStack = targetStack[0..$ - 1];
	use();
	loadRenderState();
}

Texture currentTarget = null;
Texture[] targetStack;

GLuint fb;
void use() {
	if (currentTarget is null) {
		useScreen();
		return;
	}
	glGenFramebuffers(1, &fb);
	glBindFramebuffer(GL_FRAMEBUFFER, fb);
	glFramebufferTexture2D(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_TEXTURE_2D, currentTarget.getRawTexture, 0);
    if (glCheckFramebufferStatus(GL_FRAMEBUFFER) != GL_FRAMEBUFFER_COMPLETE)
        throw new Exception("Framebuffer is wrong");
    glBindFramebuffer(GL_FRAMEBUFFER, fb);
    glViewport(0, 0, currentTarget.width, currentTarget.height);
}

void endUse() {
	if (currentTarget is null)
		return;
	glDeleteFramebuffers(1, &fb);
}

void useScreen() {
    glBindFramebuffer(GL_FRAMEBUFFER, 0);
    glViewport(0, 0, display.width, display.height);
}
