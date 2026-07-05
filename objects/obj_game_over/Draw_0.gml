/// @description Draw GUI
	//Temp values
	var cx, cy;
	
	// Make the HUD follow the camera
	draw_set_follow_camera();
	
	//Get sprite width
	var width = sprite_get_width(spr_hud_gameover);
	
	//Draw game over
	draw_sprite(spr_hud_gameover, type, (global.window_width/2)-width-8 - offset, global.window_height/2);
	draw_sprite(spr_hud_gameover, 2, (global.window_width/2)+8+offset, global.window_height/2);
	
	// Make the HUD follow the camera
	draw_set_follow_end();