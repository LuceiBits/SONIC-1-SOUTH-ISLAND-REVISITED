	// Draw the menu background
	// Affecting fonts lol
	draw_state_push();
	
	draw_sprite(spr_menu_bg, 0, 0, 0);
	
	draw_set_color(#ff7700)
	draw_triangle(0, 0, 256, 0, 0, CAMERA_VIEW_H, false);
	draw_set_color(c_black)
	
	var fixY = CAMERA_VIEW_H - floor(bg_rect_y);
	
	draw_triangle(CAMERA_VIEW_W, floor(bg_rect_y), CAMERA_VIEW_W, floor(bg_rect_y) + 64, 0, floor(bg_rect_y), false);
	draw_triangle(0, fixY - 64, CAMERA_VIEW_W, fixY, 0, fixY, false);
	draw_rectangle(0, 0, CAMERA_VIEW_W, floor(bg_rect_y), false);
	draw_rectangle(0, CAMERA_VIEW_H, CAMERA_VIEW_W, fixY, false);
	draw_set_color(c_white)
	
	draw_set_font(global.font_titlecard);
	draw_set_halign(fa_left);
	draw_set_valign(fa_center);
	
	var trueY = (CAMERA_VIEW_H / 2) - cursor_y;
	
	draw_set_colour(c_black);
	draw_rectangle(0, trueY + 2, rect_x, trueY + 16 + 2, false);
	
	draw_set_colour(#e00000);
	draw_rectangle(0, trueY, rect_x, trueY + 16, false);
	
	draw_set_colour(c_white);
	
	for (var i = 0; i < array_length(selections); ++i) 
	{
		draw_set_colour(c_black);
		draw_text(32 + text_x[i], ((CAMERA_VIEW_H / 2) + 48 * (i - 1)) + text_y[i] + 2, selections[i])
		draw_set_colour(c_white);
		
		draw_text(32 + text_x[i], ((CAMERA_VIEW_H / 2) + 48 * (i - 1)) + text_y[i], selections[i])
	}
	
	draw_state_pop();