/// @description Script	
	timer++;
	
	animator_update(animator);
	
	switch(state)
	{
		case PAUSE_STATE.TRANSITION_IN:
		black_bar_x = (transition_timer * CAMERA_VIEW_W) / 12;
		background_rect_y = (transition_timer * CAMERA_VIEW_H) / 12;
		pause_bar_x = CAMERA_VIEW_W - (transition_timer << 7) / 12;
		
		pause_elements_x = pause_bar_x;
		
		transition_timer++;
		
		highlight_x = pause_bar_x + 46;
		
		if(transition_timer > 12)
		{
			transition_timer = 12;	
			state = PAUSE_STATE.UPDATE;
		}
		break;
		
		case PAUSE_STATE.UPDATE:
		pause_alpha = math_approach(pause_alpha, 1, 16 / 255);
		
		// Get input press direction
		var i = input_press(INPUT.DOWN) - input_press(INPUT.UP);
		
		// Change the selection
		if(i != 0)
		{
			selection = math_wrap(selection + i, 0, array_length(options_array) - 1)
			highlight_x = CAMERA_VIEW_W;
			
			animator_reset(animator);
			sound_play(sfx_beep);
		}
		
		// Confirm the selection
		if(input_press(INPUT.A) || input_press(INPUT.START))
		{
			if(!allow_restart && selection == array_get_index(options_array, "RESTART"))
			{
				sound_play(sfx_menu_decline);
			}
			else
			{
				sound_play(sfx_menu_select);
				state = PAUSE_STATE.CONFIRM;
			}
		}
		break;
		
		case PAUSE_STATE.CONFIRM:
			highlight_x += 4;
			
			pause_alpha = math_approach(pause_alpha, 0, 8 / 255);
			
			if(pause_alpha = 0)
			{
				// Just unpause
				if(selection == PAUSE_TRANS.RESUME)
				{
					global.process_objects = true;
					audio_resume_all();
				}
				
				state = PAUSE_STATE.TRANSITION_UPDATE;	
			}
				
		break;
		
		case PAUSE_STATE.TRANSITION_UPDATE:
			
			// Different types of transitioning out
			if(selection == PAUSE_TRANS.RESUME)
			{
				pause_elements_x += 16;
				pause_bar_x += 16;
				black_bar_y += 16;
				
				background_rect_alpha = math_approach(background_rect_alpha, 0, 8 / 255);
				
				if(background_rect_alpha == 0)
					instance_destroy();	
			}
			else
			{
				pause_bar_x -= 16;
				pause_text_x -= 16;
				pause_elements_x += 16;
				
				if(pause_bar_x < -128)
				{
					global.process_objects = true;
					if(selection == PAUSE_TRANS.RESTART)	
					{
						level_reset_data();
						room_restart();
					}
					else
						room_goto(rm_main_menu);
				}
			}
			
		break;
	}