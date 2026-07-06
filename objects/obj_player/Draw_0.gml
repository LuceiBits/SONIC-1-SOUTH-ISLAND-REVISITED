/// @description Draw the player

	//character palettes for super form
	palette_swap(super_palettes[character],super_color);
	
	// Default flag
	var render = true;
	
	// Conditions to not render (flashing)
	if(instance_flash(6) && state != player_state_knockout && !invincible && invincible_timer > 0)
		render = false;
		
	if(render)
	{
		// Render the player after images
		_player_draw_after_images();
		
		//Draw tails segment
		if(character = CHAR_TAILS && tails.appear)
		{
			var px = floor(x) + tails.offset_x * dcos(tails.visual_angle_final) + tails.offset_y * dsin(tails.visual_angle_final);
			var py = floor(y) + tails.offset_y * dcos(tails.visual_angle_final) - tails.offset_x * dsin(tails.visual_angle_final);
			draw_animator(tails.animator, floor(px), floor(py), tails.facing, image_yscale, tails.visual_angle_final, c_white, 1.0);
		}
		
		//Draw the player:
		draw_animator(animator, floor(x), floor(y), image_xscale, 1, image_angle, c_white, 1);
	}
	
	shader_reset()
	
	//Draw spindash dust effect
	if(!global.chaotix_dust_effect && state = player_state_spindash && ground)
	{
		draw_sprite_ext(spr_effect_spindash, spindash_dust_frames, floor(x) - 2 * facing, floor(y) + hitbox_h + 1, facing, 1, 0, c_white, 1);	
	}
	
	// Draw water run effect
	if(water_run && !on_terrain && global.water_running_effect == 0)
	{
		var spdMulti = 0.4;
		draw_sprite_ext(spr_effect_water_run, FRAME_TIMER * spdMulti, floor(x - 19 * sign(x_speed)), floor(y + hitbox_h + 1), sign(x_speed), 1, 0, c_white, 1.0);	
	}