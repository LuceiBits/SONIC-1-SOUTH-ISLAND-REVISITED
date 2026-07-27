	scale_test += 0.02 * (input_hold(INPUT.DOWN) - input_hold(INPUT.UP))
	
	if(!is_exiting)
	{
		scale_test = math_approach(scale_test, 0, 0.061);
	}
	else
	{
		press_start_scale = math_approach(press_start_scale, 0, 0.02);
		if(press_start_scale == 0)
		{
			scale_test -= desc_speed;	
			desc_speed -= 0.0004;
			
			if(!triggered_transition)
			{
				music_set_fade(FADE.OUT, 1);
				fade_to_room_next(2, FADE_COLOR.BLACK, 60);
			}
			
			triggered_transition = true;
		}
	}
	
	if(input_press(INPUT.START) && !is_exiting && scale_test == 0)
	{
		sound_play(sfx_menu_select);
		is_exiting = true;
	}
	
	animator_update(sonic_face);
	animator_update(tails_face);
	animator_update(knux_face);
	
	if(animation_has_finished(sonic_face))
	{
		if(++sonic_face_timer > sonic_face_reset)
		{
			sonic_face_timer = 0;
			sonic_face_reset = irandom_range(40, 80);
			animator_reset(sonic_face);
		}
	}
	
	if(animation_has_finished(tails_face))
	{
		if(++tails_face_timer > tails_face_reset)
		{
			tails_face_timer = 0;
			tails_face_reset = irandom_range(40, 80);
			animator_reset(tails_face);
		}
	}
	
	if(animation_has_finished(knux_face))
	{
		if(++knux_face_timer > knux_face_reset)
		{
			knux_face_timer = 0;
			knux_face_reset = irandom_range(40, 80);
			animator_reset(knux_face);
		}
	}