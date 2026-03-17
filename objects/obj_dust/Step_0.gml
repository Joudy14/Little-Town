// Rotate cloud
image_angle += rotSpeed;

// Move upward
y -= driftSpeed;

// Fade out
image_alpha -= fadeSpeed;

// Destroy when invisible
if (image_alpha <= 0) {
    instance_destroy();
}