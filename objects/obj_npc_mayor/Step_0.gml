depth = -y;


if (distance_to_object(obj_player) < 90) {
	
    // Space bar progression
    if (keyboard_check_pressed(vk_space)) {
        if (instance_exists(obj_textbox)) instance_destroy(obj_textbox);
        if (global.mayor_deployed) {
            var _msg = instance_create_depth(x, y-300, -10000, obj_textbox);
            _msg.textToShow = itemTextDone;
            exit;
        }
        switch (mayor_state) {
            case 0:
                var _msg = instance_create_depth(x, y-300, -10000, obj_textbox);
                _msg.textToShow = myText;
                mayor_state = 1;
                break;
            case 1:
               if (!global.correct_given.baker || !global.correct_given.teacher || !global.correct_given.grocer) {
                    var _msg = instance_create_depth(x, y-300, -10000, obj_textbox);
                    _msg.textToShow = "You haven't solved all problems yet. Help the Baker, Teacher, and Grocer first.";
                    mayor_state = 0;
                } else {
                    var _msg = instance_create_depth(x, y-300, -10000, obj_textbox);
                    _msg.textToShow = "You have helped everyone. Are you ready to deploy?\n\n1. Yes, deploy.\n2. No, let me check again.";
                    mayor_state = 2;
                }
                break;
        }
    }

    // Number keys for confirmation (1 = yes, 2 = no)
    if (mayor_state == 2) {
        if (keyboard_check_pressed(ord("1"))) {
            if (instance_exists(obj_textbox)) instance_destroy(obj_textbox);
            mayor_state = 3;
            current_question = 0;
            design_correct = 0;
            show_next_design_question();  // defined in a script
        }
        if (keyboard_check_pressed(ord("2"))) {
            if (instance_exists(obj_textbox)) instance_destroy(obj_textbox);
            var _msg = instance_create_depth(x, y-300, -10000, obj_textbox);
            _msg.textToShow = "Take your time. Come back when you are ready.";
            mayor_state = 0;
        }
    }

    // Answer design questions (1,2,3 keys)
    if (mayor_state == 3 && global.waiting_for_design_answer) {
        var _key = -1;
        if (keyboard_check_pressed(ord("1"))) _key = 1;
        if (keyboard_check_pressed(ord("2"))) _key = 2;
        if (keyboard_check_pressed(ord("3"))) _key = 3;
        if (_key != -1) {
            global.waiting_for_design_answer = false;
            if (instance_exists(obj_textbox)) instance_destroy(obj_textbox);
            var _q = global.design_questions[current_question];
            if (_key == _q.correct + 1) {
                design_correct++;
                scr_add_points(10, x, y-50);
            }
            current_question++;
            if (current_question < array_length(global.design_questions)) {
                show_next_design_question();
            } else {
                mayor_state = 4;
                start_build_phase();  // defined in a script
            }
        }
    }
}

// Build phase progress
if (mayor_state == 4 && build_progress < global.build_progress_max) {
    build_progress++;
    if (build_progress >= global.build_progress_max) {
        var _success_chance = 0.4 + (design_correct / array_length(global.design_questions)) * 0.6;
        var _success = random(1) < _success_chance;
        if (_success) {
            var _msg = instance_create_depth(x, y-300, -10000, obj_textbox);
            _msg.textToShow = "Build successful! Your system is ready.";
            perform_final_evaluation();  // defined in a script
        } else {
            var _msg = instance_create_depth(x, y-300, -10000, obj_textbox);
            _msg.textToShow = "Build failed! The design had flaws. You need to restart the process.";
            mayor_state = 0;
            global.mayor_deployed = false;
            current_question = 0;
            design_correct = 0;
            build_progress = 0;
        }
    }
}