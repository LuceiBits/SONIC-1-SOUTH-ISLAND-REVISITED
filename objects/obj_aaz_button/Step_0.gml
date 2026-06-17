    // Make the button solid
	var col = player_act_solid();

   // Correct side conditions
	var side = (sign(image_yscale)) ? C_TOP : C_BOTTOM;
    
    if(col == side && !triggered)
	{
        triggered = true;
        
        with (obj_aaz_door)
		{
            if (door_id == other.button_id)
			{
                if (move_once && moved) 
					continue;
                
				play_sound(sfx_beep);
                state = DOOR.MOVING;
            }
        }
    } 
	
	if(triggered)
		image_index = 1;