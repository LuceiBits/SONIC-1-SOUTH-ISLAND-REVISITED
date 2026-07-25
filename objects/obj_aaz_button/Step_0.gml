	// Make the button solid
	var col = player_act_solid();

   // Correct side conditions
	var side = (sign(image_yscale)) ? C_TOP : C_BOTTOM;
    
    if(col == side)
	{
		var beep = false;
		if(image_index == 0) beep = true;
		
		image_index = 1;
		
		if(!triggered)
		{
	        triggered = true;
        
	        with (obj_aaz_door)
			{
	            if (door_id == other.button_id)
				{
	                if (move_once && moved) 
						continue;
	                state = DOOR.MOVING;
					sound_play(sfx_opendoor);
					beep = false;
	            }
	        }
		}
		if(beep) sound_play(sfx_beep);
    }
	else
	{
		image_index = 0;
	}