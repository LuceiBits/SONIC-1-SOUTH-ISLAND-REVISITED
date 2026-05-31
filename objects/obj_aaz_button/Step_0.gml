    var col,side;
    if (collision_flag) col = player_act_solid();

    if (!collision_flag)    side = C_MAIN;
    else                    side = (image_angle == 180)? C_TOP : C_BOTTOM;
    
    if (player_collide_object(id, side) && !triggered){
        image_index = 1;
        triggered = true;
        
        with (obj_aaz_door){
            if (door_id == other.button_id){
                if (move_once && moved) continue;
                
				audio_play_sound(sfx_beep, 1, false, 2.5);
                state = DOOR.MOVING;
            }
        }
    } else if (player_collide_object(id, side) && triggered){
        image_index = 1;
    } else {
        image_index = 0;
        triggered = false;
    }
	
	if (!on_screen()) instance_deactivate_object(id);