// @description Main Step Logic

// ==========================================
// 1. MOVEMENT INPUT (With Inventory Gate)
// ==========================================
// Only detect keys if player has control AND menus are closed
if (global.playerControl == true && global.inventory_open == false && obj_control.menuActive == false) {
    moveRight = keyboard_check(vk_right);
    moveUp = keyboard_check(vk_up);
    moveLeft = keyboard_check(vk_left);
    moveDown = keyboard_check(vk_down);
    running = keyboard_check(ord("X"));
} else {
    // Force everything to zero/false so the player freezes
    moveRight = 0;
    moveUp = 0;
    moveLeft = 0;
    moveDown = 0;
    running = false;
}

// ==========================================
// 2. RUNNING & DUST LOGIC
// ==========================================
if (running == true) {
    // Ramp up
    if (runSpeed < runMax) {
        runSpeed += 2;
    }
    // Start creating dust
    if (startDust == 0) {
        alarm[0] = 2;
        startDust = 1;
    }
} else {
    // Slow down if no longer running
    if (runSpeed > 0) {
        runSpeed -= 1;
    }
    startDust = 0;
}

// ==========================================
// 3. CALCULATE VELOCITY (Diagonal Speed Fix)
// ==========================================
var _moveX = (moveRight - moveLeft);
var _moveY = (moveDown - moveUp);

if (_moveX != 0 || _moveY != 0) {
    // 1. Get the exact direction of movement (0 to 360 degrees)
    var _dir_angle = point_direction(0, 0, _moveX, _moveY);
    
    // 2. Determine current base speed
    var _spd = (running == true) ? (walkSpeed + runSpeed) : walkSpeed;
    _spd = _spd * (1 - carryLimit);
    
    // 3. Normalize the vector! This applies the speed perfectly in the chosen direction
    vx = lengthdir_x(_spd, _dir_angle);
    vy = lengthdir_y(_spd, _dir_angle);
} else {
    vx = 0;
    vy = 0;
}

// ==========================================
// 4. COLLISIONS & MOVEMENT EXECUTION
// ==========================================
if (vx != 0 || vy != 0) {
    if !collision_point(x+vx,y,obj_par_environment,true,true) {
        x += vx;
    }
    if !collision_point(x,y+vy,obj_par_environment,true,true) {
        y += vy;
    }
    
    // Change direction based on movement
    if (vx > 0) dir = 0;
    if (vx < 0) dir = 2;
    if (vy > 0) dir = 3;
    if (vy < 0) dir = 1;

    // Set state
    if (hasItem == noone) {
        myState = playerState.walking;
    } else {
        myState = playerState.carrying;
    }
    
    // Audio Listener positioning
    if (instance_exists(obj_control) && obj_control.sequenceState == seqState.playing) {
        var _camX = camera_get_view_x(view_camera[0]) + floor(camera_get_view_width(view_camera[0]) * 0.5);
        var _camY = camera_get_view_y(view_camera[0]) + floor(camera_get_view_height(view_camera[0]) * 0.5);
        audio_listener_set_position(0,_camX,_camY,0);
    } else {
        audio_listener_set_position(0,x,y,0);
    }
}

// ==========================================
// 5. IDLE STATES
// ==========================================
if (vx == 0 && vy == 0) {
    if (myState != playerState.pickingUp && myState != playerState.puttingDown) {
        if (hasItem == noone) {
            myState = playerState.idle;
        } else {
            myState = playerState.carryIdle;
        }
    }
}

// ==========================================
// 6. NPC & ITEM COLLISIONS (Prompts)
// ==========================================
nearbyNPC = collision_rectangle(x-lookRange,y-lookRange,x+lookRange,y+lookRange,obj_par_npc,false,true);
if (nearbyNPC) {
    if (hasGreeted == false) {
        if !(audio_is_playing(snd_greeting01)) {
            audio_play_sound(snd_greeting01,1,0);
            hasGreeted = true;
        }
    }
    if (npcPrompt == noone || npcPrompt == undefined) {
        npcPrompt = scr_showPrompt(nearbyNPC,nearbyNPC.x,nearbyNPC.y-450);
    }
} else {
    if (hasGreeted == true) hasGreeted = false;
    scr_dismissPrompt(npcPrompt,0);
}

nearbyItem = collision_rectangle(x-lookRange,y-lookRange,x+lookRange,y+lookRange,obj_par_item,false,true);
if (nearbyItem && !nearbyNPC && (hasItem == noone)) {
    if (itemPrompt == noone || itemPrompt == undefined) {
        itemPrompt = scr_showPrompt(nearbyItem,nearbyItem.x,nearbyItem.y-300);
    }
} else {
    if (itemPrompt != noone) {
        scr_dismissPrompt(itemPrompt,1);
        itemPrompt = noone;
    }
}

// ==========================================
// 7. ANIMATION STATE OVERRIDES
// ==========================================
if (myState == playerState.pickingUp) {
    if (image_index >= image_number-1) {
        myState = playerState.carrying;
        global.playerControl = true;
    }
}

if (myState == playerState.puttingDown) {
    carryLimit = 0;
    if (image_index >= image_number-1) {
        myState = playerState.idle;
        global.playerControl = true;
    }
}

// ==========================================
// 8. FINAL UPDATES
// ==========================================
sprite_index = playerSpr[myState][dir];
depth = -y;



// Check for collision with Chest
nearbyChest = collision_rectangle(x - lookRange, y - lookRange, x + lookRange, y + lookRange, obj_chest, false, true);

// ==========================================
// ROOM TRANSITIONS - COMPLETE WITH ALL COORDINATES
// ==========================================

// --- MAIN ROOM (rm_gameMain) ---
if (room == rm_gameMain) {
    
    // DOWN to FOREST
    if (x > 2934 && x < 3034 && y > 2924 && y < 3024) {
        room_goto(rm_forest);
        x = 1792;
        y = 200;
    }
    
    // RIGHT to RIVER
    if (x > 4901 && x < 5001 && y > 1351 && y < 1451) {
        room_goto(rm_river);
        x = 227;
        y = 998;
    }
}

// --- FOREST ROOM (rm_forest) ---
if (room == rm_forest) {
    
    // UP to MAIN
    if (x > 1743 && x < 1843 && y > 26 && y < 126) {
        room_goto(rm_gameMain);
        x = 2995;
        y = 2900;
    }
}

// --- RIVER ROOM (rm_river) ---
if (room == rm_river) {
    
    // LEFT to MAIN (using your new exit point)
    if (x > 43 && x < 143 && y > 967 && y < 1067) {
        room_goto(rm_gameMain);
        x = 4900;    // Just left of main exit (4951 - 51)
        y = 1401;    // Same Y as main exit
    }
}


// Bridge prompt
if (nearbyBridge && !nearbyBridge.is_built && !nearbyNPC) {
    if (bridgePrompt == noone) {
        bridgePrompt = scr_showPrompt(nearbyBridge, nearbyBridge.x, nearbyBridge.y - 50);
    }
} else {
    if (bridgePrompt != noone) {
        scr_dismissPrompt(bridgePrompt, 0);
        bridgePrompt = noone;
    }
}

nearbyBridge = collision_rectangle(x - 50, y - 50, x + 50, y + 50, obj_bridge, false, true);

