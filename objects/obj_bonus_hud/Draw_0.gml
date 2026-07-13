/// @description Draw the HUD

	//Don't render the hud
	if(!render)
	{
		exit;	
	}
	
	//Temp value
	var minute, sec, milsec;
	
	//Time
	milsec = floor(global.stage_timer/10) mod 100;
	sec = floor(global.stage_timer/1000) mod 60;
	minute = floor(global.stage_timer/60000);
	
	// Make the HUD follow the camera
	draw_set_follow_camera();
		
	draw_sprite(spr_hudtext, 2, 16 + offset[0], 8);
		
	//Red flashing text
	if(global.rings == 0 && FRAME_TIMER mod 20 < 20/2) draw_sprite(spr_hudtext, 4, 16 + offset[0], 8);
	//Draw life icon
	draw_sprite(spr_hud_life_icons, global.character, 16 + offset[1], global.window_height - 26);
		
	//Set font numbers
	draw_set_font(global.hud_number);
	draw_set_halign(fa_right);
		
	draw_text(96 + offset[0], 9, string(global.rings));
	draw_text(56 + offset[1], global.window_height - 24, (global.life > 9 ? "" : "0") + string(global.life));
		
	if (obj_player.combinering == 1)
	{
		draw_sprite(spr_monitor_icon_combine_ring, 0, 24 + offset[0], 16);	
	}
	
	
	// Stop following the camera
	draw_set_follow_end();
	
	if(slide_in)
	{
		for(var i = 0; i <= 3; i++)
		{
			var debug_offset = 0;
			if(instance_exists(obj_dev)) debug_offset = -128 * obj_dev.debug;
			offset[i] = math_approach(offset[i], debug_offset, 8);	
		}
	}
	
