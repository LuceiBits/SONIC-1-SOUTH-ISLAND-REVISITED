function player_state_pole_current()
{
	
	live_auto_call
	gravity_allow = false
	
	with pole_id
	{
		other.x = x
		//swing_pole_cooldown = 10
	}
	
	control_lock = 2
	
		on_terrain = false
		ground = false
	
		var _movy = hold_down - hold_up
		
		var _movespeed = 2
		
		//x_speed = lengthdir_x(water_current_id.spd, _angle) + (_movespeed * _movx)
		y_speed = 0
		
		y_speed = (_movespeed * _movy)		
	
	pole_anim_speed = 0
	animation_set_duration(animator, pole_anim_speed)
	
	//show_debug_message(animation_get_duration(animator))
	


		

	
if jump_buffer || press_action
{
		gravity_allow = true;
		with pole_id
		swing_pole_cooldown = 20
		state = player_state_normal
		show_debug_message("jumped off current pole?")
		on_terrain = false
		ground = false
		pole_id = noone
		jump_buffer = 0
	//	exit;
	}

}

	//if movement != 0
		//image_xscale = movement
	
	//if ground
	//{
	//	with pole_id
	//		swing_pole_cooldown = 10
		
	//	//if movement != 0
	//	//{
	//	//	ground_speed = (abs(pole_xspd_save) + abs(y_speed/2)) * movement
	//	//	//facing = movement
	//	//}
	//	//else
	//	//{
	//	//	ground_speed = (abs(pole_xspd_save) + abs(y_speed/2)) * image_xscale
	//	//	//facing = image_xscale
	//	//}
		
	//	pole_id = noone
	//	state = force_roll ? player_state_roll : player_state_normal;
	//	jump_buffer = 0
	//	exit;
	//}

	