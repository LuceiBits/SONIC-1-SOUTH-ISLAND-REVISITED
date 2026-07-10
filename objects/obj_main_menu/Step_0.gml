	timer++;
	
	for (var i = 0; i < array_length(selections); ++i) 
	{
		if(timer > 10 + 4 * i)
		{
			text_ease_timer[i] = math_approach(text_ease_timer[i], 0, 0.02);	
		}
		
		text_x[i] = -256 * ease_in_back(text_ease_timer[i]);
		
		text_y[i] = lerp(text_y[i], -4 * (select == i), 0.3);
	}
	
	rect_ease_timer = math_approach(rect_ease_timer, 1, 0.02);
	rect_x = CAMERA_VIEW_W * ease_out_sine(rect_ease_timer);
	
	bg_rect_timer = math_approach(bg_rect_timer, 0, 0.02);
	bg_rect_y = (CAMERA_VIEW_H / 2) * ease_in_back(bg_rect_timer);
	
	var i = input_press(INPUT.DOWN) - input_press(INPUT.UP);
	
	if(i != 0)
	{
		select = math_wrap(select + i, 0, array_length(selections) - 1);	
		
		play_sound(sfx_beep);
	}
	
	cursor_y = lerp(cursor_y, -48 * (select - 1), 0.3 * rect_ease_timer);