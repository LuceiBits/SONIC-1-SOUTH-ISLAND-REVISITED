/// @description Draw End Card

	// Make the HUD follow the camera
	draw_set_follow_camera();
	
	//Draw the end card text
	draw_sprite(spr_hud_actclear_character, global.character, global.window_width/2 - offset_x[0], global.window_height/2 - 50);
	draw_sprite(spr_hud_actclear_thru_act, obj_level.act, global.window_width/2 + offset_x[0], global.window_height/2 - 32);
	
	draw_sprite(spr_hud_actclear_time_bonus, 0, global.window_width/2-98 + offset_x[1], global.window_height/2);
	draw_sprite(spr_hud_actclear_ring_bonus, 1, global.window_width/2-98 + offset_x[2], global.window_height/2 + 16);
	draw_sprite(spr_hud_actclear_total_bonus, 2, global.window_width/2-82 + offset_x[3], global.window_height/2 + 48);
	
	
	//Draw numbers
	draw_set_halign(fa_right);
	draw_set_font(global.hud_number);
	
	//Draw text
	draw_text(global.window_width/2+82 + offset_x[1], global.window_height/2, string(time_bonus));
	draw_text(global.window_width/2+82 + offset_x[2], global.window_height/2+16, string(ring_bonus));
	draw_text(global.window_width/2+74 + offset_x[3], global.window_height/2+48, string(total_bonus));
	
	draw_set_halign(fa_left);
	
	// Stop following the camera
	draw_set_follow_end();