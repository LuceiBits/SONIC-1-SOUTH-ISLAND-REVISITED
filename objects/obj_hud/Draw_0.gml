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
	
	if (!instance_exists(obj_bonus_cont)) 
	{
		//Draw normal text
		draw_sprite(spr_hudtext, 0, 16 + offset[0], 8);
		draw_sprite(spr_hudtext, 1, 16 + offset[1], 24);
		draw_sprite(spr_hudtext, 2, 16 + offset[2], 40);
	
		//Red flashing text
		if(global.rings == 0 && FRAME_TIMER mod 20 < 20/2) draw_sprite(spr_hudtext, 4, 16 + offset[2], 40);
		if(global.stage_timer >= 540000 && FRAME_TIMER mod 20 < 20/2) draw_sprite(spr_hudtext, 3, 16 + offset[1], 24);
	
		//Draw life icon
		draw_sprite(spr_hud_life_icons, global.character, 16 + 1 + offset[3], global.window_height - 26 + 3);
	
		//Set font numbers
		draw_set_font(global.hud_number);
		draw_set_halign(fa_right);
		draw_set_valign(fa_top);
	
		//Draw number
		draw_text(120 - 8 + offset[0], 8, string(global.score));
		draw_text(120 - 8 + offset[1], 24, string(minute)+" "+(sec > 9 ? "" : "0") + string(sec)+" "+(milsec > 9 ? "" : "0") + string(milsec));
		draw_text(96 - 8 + offset[2], 40, string(global.rings));
		draw_text(56 + offset[3], global.window_height - 24 + 4, (global.life > 9 ? "" : "0") + string(global.life));
		
		if (obj_player.combinering == 1){
			draw_sprite(spr_monitor_icon_combine_ring, 0, 24 + offset[2], 64);	
		}
		if (obj_player.combineloss == 1){
			if (FRAME_TIMER mod 2 = 0){
				draw_sprite(spr_monitor_icon_combine_ring, 0, 24 + offset[2], 64);	
			}
		}
	} 
	else 
	{
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
	
