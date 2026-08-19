function player_state_poleswing()
{
	live_auto_call

	var movement = hold_right - hold_left;
	
	with pole_id
		other.x = x
	
	pole_anim_speed = abs(pole_xspd_save)
	if !animation_is_playing(animator,ANIM.POLESWING)
	{
	animation_play(animator, ANIM.POLESWING);
	pole_anim_speed = clamp(pole_anim_speed,2,pole_anim_speed)
	animation_set_duration(animator, 10/ pole_anim_speed,ANIM.POLESWING)
	}
	//show_debug_message(animation_get_duration(animator))
	
	if !ground
	{
		y_speed *= 0.99
		x_speed = 0
	}

	if movement != 0
		image_xscale = movement
	
	if ground
	{
		with pole_id
			swing_pole_cooldown = 10
		
		if movement != 0
		{
			ground_speed = (abs(pole_xspd_save) + abs(y_speed/2)) * movement
			x_speed = (abs(pole_xspd_save) + abs(y_speed/2)) * movement
			//facing = movement
		}
		else
		{
			ground_speed = (abs(pole_xspd_save) + abs(y_speed/2)) * image_xscale
			x_speed = (abs(pole_xspd_save) + abs(y_speed/2)) * image_xscale
			//facing = image_xscale
		}
		
		pole_id = noone
		state = force_roll ? player_state_roll : player_state_normal;
		jump_buffer = 0
		exit;
	}

	if jump_buffer || press_action || y < pole_id.bbox_top || y > pole_id.bbox_bottom - 10
	{
		jump_flag = true
		with pole_id
		{
			swing_pole_cooldown = 10	
		}
		
		if movement != 0
			x_speed = abs(pole_xspd_save) * movement
		else
			x_speed = abs(pole_xspd_save) * image_xscale
			
		if !(y > pole_id.bbox_bottom - 10 && sign(y_speed) != -1)
			y_speed = jump_strength * -1
		
		if x_speed != 0
			facing = sign(x_speed)
		state = player_state_jump
		
		jump_buffer = 0
		
		with pole_id
		{
			if destroyable = true
			{
			other.pole_id = noone
			instance_destroy()
			}
		}
		
		pole_id = noone
			
		exit;
	}

}