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
		
		if(timer > 60)
		{
			var i = input_press(INPUT.DOWN) - input_press(INPUT.UP);
	
			if(i != 0)
			{
				select = math_wrap(select + i, 0, array_length(selections) - 1);	
		
				sound_play(sfx_beep);
			}
	
			if(input_press(INPUT.A) || input_press(INPUT.START))
			{
				selected = true;
				selected_timer = 0;
		
				sound_play(sfx_menu_select);
			}
		}
		
		cursor_y = lerp(cursor_y, -48 * (select - 1), 0.3 * rect_ease_timer);
	}
	else
	{
		selected_timer++;
		
		rect_ease_timer = math_approach(rect_ease_timer, 0, 0.04);
		rect_x = CAMERA_VIEW_W * ease_out_sine(rect_ease_timer);
		
		if(selected_timer == 40)
		{
			switch(select)
			{
				case 0:
				different_bg = true;	
				instance_create_depth(0, 0, depth - 10, obj_character_select);
				break;
				
				case 1:
				different_bg = true;	
				instance_create_depth(0, 0, depth - 10, obj_options);
				break;
			}
		}
		
		// Exit the game
		if(select == 2)
		{
			fade_change(FADE_OUT, 2);
			music_set_fade(FADE_OUT, 2);
				
			if(obj_global.fade.timer == 0)
				game_end();	
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
	}
	
	// The alternative background
	different_bg_fade = math_approach(different_bg_fade, different_bg, 0.05);
	
	// Character sprite
	var charsprite = select;
	if(instance_exists(obj_character_select))
		charsprite += obj_character_select.select;
	if(select == 2) charsprite = 3;
	
	if(current_char != charsprite)
	{
		current_char = charsprite;
		char_bounce = 1;
	}
	
	char_bounce = math_approach(char_bounce, 0, 0.025);