if (myEmitter != -1 && audio_emitter_exists(myEmitter)) {
    audio_emitter_free(myEmitter);
    myEmitter = -1;
}