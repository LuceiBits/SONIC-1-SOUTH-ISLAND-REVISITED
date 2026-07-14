	// Update variables
	option_variables[0] = string(window_get_width()) + "X" + string(window_get_height());
	option_variables[1] = floor(global.bgm_volume * 100);
	option_variables[2] = floor(global.sfx_volume * 100);
	
	timer++;
	
	if(!returning)
	{
		// Get the input direction
		var h = input_press(INPUT.RIGHT) - input_press(INPUT.LEFT);
		var v = input_press(INPUT.DOWN) - input_press(INPUT.UP);
		
		if(v != 0)
		{
			select = math_wrap(select + v, 0, array_length(option_name));
			sound_play(sfx_beep);	
		}
		
		if(select < array_length(option_name))
		{
			cursor_y = lerp(cursor_y, (CAMERA_VIEW_H / 2) - 64 + (24 * select), 0.3);
		}
		else
		{
			cursor_y = lerp(cursor_y, (CAMERA_VIEW_H / 2) + 96, 0.3);	
			
			if(input_press(INPUT.A) || input_press(INPUT.START))
			{
				sound_play(sfx_menu_select);
				returning = true;	
			}
		}
		
		// Change the options
		if(h != 0)
		{
			sound_play(sfx_beep);
			
			switch(select)
			{
				case 0:
				global.window_size = clamp(global.window_size + h, 1, global.window_size_limit);
				game_call_window_resize();
				break;
				
				case 1:
				global.bgm_volume = clamp(global.bgm_volume + (h * 0.1), 0, 1);
				break;
				
				case 2:
				global.sfx_volume = clamp(global.sfx_volume + (h * 0.1), 0, 1);
				break;
			}
		}
		
		if(input_press(INPUT.B))
		{
			sound_play(sfx_menu_select);
			returning = true;		
		}
		
		// Transitioning in
		transition_timer = math_approach(transition_timer, 0, 0.03);
		transition_offset = 200 * ease_in_cubic(transition_timer);
		
		for (var i = 0; i < array_length(option_name); ++i) 
		{
			option_offset[i] = 256 * ease_in_circ(option_ease[i]);
			
			if(timer > 4 * i)
				option_ease[i] = math_approach(option_ease[i], 0, 0.02);
		}
		
		cursor_size = math_approach(cursor_size, 8, 0.25);
	}
	else
	{
		return_timer++;	
		
		transition_timer = math_approach(transition_timer, 1, 0.03);
		transition_offset = 200 * ease_in_cubic(transition_timer);
		
		for (var i = 0; i < array_length(option_name); ++i) 
		{
			option_offset[i] = 256 * ease_in_circ(option_ease[i]);
			
			if(timer > 4 * i)
				option_ease[i] = math_approach(option_ease[i], 1, 0.05);
		}
		
		cursor_size = math_approach(cursor_size, 0, 0.5);
		
		if(return_timer > 40)
		{
			instance_destroy();	
			
			with(menu)
			{
				selected = false;
				selected_timer = 0;
				timer = 0;	
				different_bg = false;	
			}
		}
	}