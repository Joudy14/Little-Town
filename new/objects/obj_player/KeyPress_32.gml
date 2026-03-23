var _text;

// Only if player can act
if (global.playerControl == true) {

    // ================= NPC =================
    if (nearbyNPC) {

        if (hasItem == noone) {

            _text = nearbyNPC.myText;

            if (!instance_exists(obj_textbox)) {
                var iii = instance_create_depth(nearbyNPC.x, nearbyNPC.y - 400, -10000, obj_textbox);
                iii.textToShow = _text;
            }
        }
    }

    // ================= DROP ITEM (ANYWHERE) =================
    else if (hasItem != noone) {

        myState = playerState.puttingDown;
        image_index = 0;
        global.playerControl = false;

        with (hasItem) {
            putDownY = obj_player.y + 5;
            myState = itemState.puttingBack;
        }

        audio_play_sound(snd_itemPutDown, 1, 0);

        hasItem = noone;
    }

    // ================= PICK UP ITEM =================
    else if (nearbyItem) {

        global.playerControl = false;
        myState = playerState.pickingUp;
        image_index = 0;

        hasItem = nearbyItem;

        // SAFE check (prevents crash)
        if (hasItem != noone) {
            carryLimit = hasItem.itemWeight * 0.1;
        }

        with (hasItem) {
            myState = itemState.taken;
        }

        audio_play_sound(snd_itemPickup, 1, 0);
    }
}