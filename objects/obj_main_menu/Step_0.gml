	timer++;
	
	bg_rect_timer = math_approach(bg_rect_timer, 0, 0.02);
	bg_rect_y = (CAMERA_VIEW_H / 2) * ease_in_back(bg_rect_timer);
	
	if(!selected)
	{
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
	
		var i = input_press(INPUT.DOWN) - input_press(INPUT.UP);
	
		if(i != 0)
		{
			select = math_wrap(select + i, 0, array_length(selections) - 1);	
		
			play_sound(sfx_beep);
		}
	
		cursor_y = lerp(cursor_y, -48 * (select - 1), 0.3 * rect_ease_timer);
	
		if(input_press(INPUT.A) || input_press(INPUT.START))
		{
			selected = true;
			selected_timer = 0;
		
			play_sound(sfx_menu_select);
		}
	}
	else
	{
		selected_timer++;
		
		rect_ease_timer = math_approach(rect_ease_timer, 0, 0.04);
		rect_x = CAMERA_VIEW_W * ease_out_sine(rect_ease_timer);
		
		if(selected_timer == 60)
		{
			different_bg = true;	
		}
		
		for (var i = 0; i < array_length(selections); ++i) 
		{
			if(selected_timer > 4 * i)
			{
				text_ease_timer[i] = math_approach(text_ease_timer[i], 1, 0.02);	
			}
		
			text_x[i] = (CAMERA_VIEW_W + 128) * ease_in_sine(text_ease_timer[i]);
			text_y[i] = lerp(text_y[i], 0, 0.3);
		}
		
		if(input_press(INPUT.B))
		{
			selected = false;
			selected_timer = 0;
			timer = 0;
			
			different_bg = false;
			
			play_sound(sfx_menu_select);
		}
	}
	
	// The alternative background
	different_bg_fade = math_approach(different_bg_fade, different_bg, 0.05);