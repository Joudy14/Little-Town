function scr_check_master_analyst() {
    if (global.correct_given.baker && global.correct_given.teacher && global.correct_given.grocer &&
        global.validated.baker && global.validated.teacher && global.validated.grocer) {
        scr_unlock_achievement("master_analyst", "Master Analyst");
    }
}