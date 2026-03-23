enum seqState {
    notPlaying,
    playing,
    finished
}

global.sequenceState = seqState.notPlaying;
curSeq = noone;
curSeqLayer = "Cutscene";