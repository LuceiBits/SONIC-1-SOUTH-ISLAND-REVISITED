	scale_test += 0.02 * (input_hold(INPUT.DOWN) - input_hold(INPUT.UP))
	
	if(!is_exiting)
	{
		scale_test = math_approach(scale_test, 0, 0.061);
	}
	else
	{
		scale_test += desc_speed;	
		desc_speed -= 0.0004;
	}
	
	if(input_press(INPUT.START) && !is_exiting)
	{
		is_exiting = true;
		music_set_fade(FADE.OUT, 1);
		fade_to_room_next(2, FADE_COLOR.BLACK, 60);
	}