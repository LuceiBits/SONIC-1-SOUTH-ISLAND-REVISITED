	
	draw_set_font(global.font_titlecard);
	draw_set_halign(fa_center);
	draw_set_valign(fa_center);
	
	var trueX = 0;
	var trueY = (CAMERA_VIEW_H / 2) + transition_offset;
	
	draw_text_colour(CAMERA_VIEW_W / 2, (CAMERA_VIEW_H / 2) - 96 + 4 - transition_offset, "CHOOSE YOUR CHARACTER", c_black, c_black, c_black, c_black, 1.0);
	draw_text(CAMERA_VIEW_W / 2, (CAMERA_VIEW_H / 2) - 96 - transition_offset, "CHOOSE YOUR CHARACTER");
	
	draw_set_font(global.font_small);
	for (var i = 0; i < 3; ++i) 
	{
		trueX = (CAMERA_VIEW_W / 2) + 96 * (i - 1);
		draw_sprite(spr_character_select_border, 0, trueX, trueY - char_y[i]);
		
		draw_sprite(spr_character_select_chars, i, trueX, trueY - char_y[i]);
		
		draw_text(trueX, trueY - 40 - char_y[i], char_names[i]);
	}