	
	draw_set_font(global.font_titlecard);
	draw_set_halign(fa_center);
	draw_set_valign(fa_center);
	
	var trueX = 0;
	var trueY = (CAMERA_VIEW_H / 2) + transition_offset;
	
	draw_set_alpha(0.5);
	draw_rectangle(0, floor(cursor_y - cursor_size), CAMERA_VIEW_W, floor(cursor_y + cursor_size), false);
	draw_set_alpha(1);
	
	draw_text_colour(CAMERA_VIEW_W / 2, (CAMERA_VIEW_H / 2) - 96 + 4 - transition_offset, "GAME OPTIONS", c_black, c_black, c_black, c_black, 1.0);
	draw_text(CAMERA_VIEW_W / 2, (CAMERA_VIEW_H / 2) - 96 - transition_offset, "GAME OPTIONS");
	
	draw_set_font(global.font_small);
	draw_text(CAMERA_VIEW_W / 2, (CAMERA_VIEW_H / 2) + 96 + transition_offset, "EXIT");
	
	for (var i = 0; i < array_length(option_name); ++i) 
	{
		draw_set_halign(fa_left);
		draw_text((CAMERA_VIEW_W / 2) - 152 - option_offset[i], (CAMERA_VIEW_H / 2) - 64 + (24 * i), option_name[i]);
		
		draw_set_halign(fa_right);
		draw_text((CAMERA_VIEW_W / 2) + 152 + option_offset[i], (CAMERA_VIEW_H / 2) - 64 + (24 * i), option_variables[i]);
	}