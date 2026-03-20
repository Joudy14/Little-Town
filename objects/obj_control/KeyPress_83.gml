if (global.sequenceState == seqState.notPlaying) {

    curSeq = layer_sequence_create(
        curSeqLayer,
        room_width/2,
        room_height/2,
        seq_bakery_happy
		
    );

    global.sequenceState = seqState.playing;
}