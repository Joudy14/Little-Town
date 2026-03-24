if (global.sequenceState == seqState.playing) {
    moveRight = 0;
    moveLeft = 0;
    moveUp = 0;
    moveDown = 0;
} 
if (global.playerControl) {
    moveRight = keyboard_check(vk_right);
    moveUp    = keyboard_check(vk_up);
    moveLeft  = keyboard_check(vk_left);
    moveDown  = keyboard_check(vk_down);
} else {
    moveRight = 0;
    moveUp    = 0;
    moveLeft  = 0;
    moveDown  = 0;
}

// ================= RUNNING =================
running = keyboard_check(vk_shift);

// ================= SPEED =================
var moveSpeed = walkSpeed;

if (running) {
    moveSpeed = runMax;
}

// ================= CALCULATE MOVEMENT =================
vx = (moveRight - moveLeft) * moveSpeed * (1 - carryLimit);
vy = (moveDown - moveUp) * moveSpeed * (1 - carryLimit);

// ================= IDLE =================
if (vx == 0 && vy == 0) {
    if (myState != playerState.pickingUp && myState != playerState.puttingDown) {
        if (hasItem == noone) {
            myState = playerState.idle;
        } else {
            myState = playerState.carryIdle;
        }
    }
}

// ================= MOVING =================
if (vx != 0 || vy != 0) {

    if (!collision_point(x + vx, y, obj_par_environment, true, true)) {
        x += vx;
    }

    if (!collision_point(x, y + vy, obj_par_environment, true, true)) {
        y += vy;
    }

    // Direction
    if (vx > 0) dir = 0;
    if (vx < 0) dir = 2;
    if (vy > 0) dir = 3;
    if (vy < 0) dir = 1;

    // ================= DUST EFFECT (7.16–7.17) =================
    if (running) {
        if (irandom(5) == 0) {
            instance_create_depth(x, y, depth + 1, obj_dust);
        }
    }

    // State
    if (hasItem == noone) {
        myState = playerState.walking;
    } else {
        myState = playerState.carrying;
    }

  // Set my listener if Sequence is playing
if (instance_exists(obj_control) && obj_control.sequenceState == seqState.playing)
{
var _camX =
camera_get_view_x(view_camera[0])+floor(camera_get_view_width(view_camera[0])*0.5)
;
var _camY =
camera_get_view_y(view_camera[0])+floor(camera_get_view_height(view_camera[0])*0.5
);
audio_listener_set_position(0,_camX,_camY,0);
}
else {
// Otherwise, move audio listener with me
audio_listener_set_position(0,x,y,0);
}
}

// ================= NPC DETECTION =================
nearbyNPC = collision_rectangle(
    x - lookRange, y - lookRange,
    x + lookRange, y + lookRange,
    obj_par_npc, false, true
);

if (nearbyNPC) {

    if (!hasGreeted) {
        if (!audio_is_playing(snd_greeting01)) {
            audio_play_sound(snd_greeting01, 1, 0);
            hasGreeted = true;
        }
    }

    if (npcPrompt == noone || npcPrompt == undefined) {
        npcPrompt = scr_showPrompt(nearbyNPC, nearbyNPC.x, nearbyNPC.y - 450);
    }

} else {

    if (hasGreeted) {
        hasGreeted = false;
    }

    scr_dismissPrompt(npcPrompt, 0);
}

// ================= ITEM DETECTION =================
nearbyItem = collision_rectangle(
    x - lookRange, y - lookRange,
    x + lookRange, y + lookRange,
    obj_par_item, false, true
);

if (nearbyItem && !nearbyNPC) {

    if (itemPrompt == noone || itemPrompt == undefined) {
        itemPrompt = scr_showPrompt(nearbyItem, nearbyItem.x, nearbyItem.y - 300);
    }

} else {

    scr_dismissPrompt(itemPrompt, 1);
}

// ================= PICKUP =================
if (myState == playerState.pickingUp) {
    if (image_index >= image_number - 1) {
        myState = playerState.carrying;
        global.playerControl = true;
    }
}

// ================= PUT DOWN =================
if (myState == playerState.puttingDown) {

    carryLimit = 0;

    if (image_index >= image_number - 1) {
        myState = playerState.idle;
        global.playerControl = true;
    }
}

// ================= SPRITE =================
sprite_index = playerSpr[myState][dir];

// ================= DEPTH =================
depth = -y;