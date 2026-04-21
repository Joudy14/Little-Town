// Update emitter position to follow the key
if (myEmitter != 0) {
    audio_emitter_position(myEmitter, x, y, 0);
}

// Depth sorting
depth = -y;