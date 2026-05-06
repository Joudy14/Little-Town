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
// 7. ANIMATION STATE OVERRIDES & INVENTORY ADD
// ==========================================
if (myState == playerState.pickingUp) {
    if (image_index >= image_number-1) {
        show_debug_message("PICKUP ANIMATION FINISHED");
        if (global.pending_item_name != "") {
            array_push(global.inventory, global.pending_item_name);
            array_push(global.inventory_keys, global.pending_item_key);
            array_push(global.picked_up_items, global.pending_item_key);
            show_debug_message("Added to inventory: " + global.pending_item_name);
            show_debug_message("picked_up_items now: " + string(global.picked_up_items));
			
			            // --- ADD COLLECTOR ACHIEVEMENT CHECK ---
            if (!array_contains(global.items_collected, global.pending_item_key)) {
                array_push(global.items_collected, global.pending_item_key);
                if (array_length(global.items_collected) >= 6) {
                    scr_unlock_achievement("collector");
                }
            }
			
            // Clear pending
            global.pending_item_name = "";
            global.pending_item_key = "";
        } else {
            show_debug_message("No pending item");
        }
        // Destroy the world item if it still exists
        if (hasItem != noone && instance_exists(hasItem)) {
            with (hasItem) instance_destroy();
        }
        myState = playerState.carrying;
        global.playerControl = true;
        hasItem = noone;
    }
}


// ==========================================
// 8. FINAL UPDATES
// ==========================================
sprite_index = playerSpr[myState][dir];
depth = -y;



// Check for collision with Chest
nearbyChest = collision_rectangle(x - lookRange, y - lookRange, x + lookRange, y + lookRange, obj_chest, false, true);


// Chest prompt
if (nearbyChest && !nearbyChest.is_open && !nearbyNPC) {
    if (chestPrompt == noone) {
        chestPrompt = scr_showPrompt(nearbyChest, nearbyChest.x, nearbyChest.y - 50);
    }
} else {
    if (chestPrompt != noone) {
        scr_dismissPrompt(chestPrompt, 0);
        chestPrompt = noone;
    }
}

// Spawn pending chest reward when textbox closes
if (global.pending_reward_x != noone && !instance_exists(obj_textbox)) {
    var _reward = instance_create_layer(global.pending_reward_x, global.pending_reward_y, "Instances", global.pending_reward_item);
    _reward.item_key = "item03";   // or set item properties as needed
    show_debug_message("Reward spawned after textbox closed");
    // Clear pending
    global.pending_reward_x = noone;
    global.pending_reward_y = noone;
    global.pending_reward_item = noone;
}

// River area message (position‑based)
var _river_x = 6840;
var _river_y = 1727;
var _radius = 200;  // pixels around the point

if (!global.river_message_shown_near && point_distance(x, y, _river_x, _river_y) < _radius) {
    global.river_message_shown_near = true;
    var _msg = instance_create_depth(x, y - 80, -10000, obj_textbox);
    _msg.textToShow = "To cross the river, you need to build a bridge.";
}


// Detect bridge
nearbyBridge = collision_rectangle(x - 50, y - 50, x + 50, y + 50, obj_bridge, false, true);

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