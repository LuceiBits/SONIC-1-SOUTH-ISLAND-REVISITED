/// @self					obj_player	
/// @description			Function that handles player's miscellaneous things
function player_misc()
{
	//Subtract timers
	control_lock = max(control_lock-1, 0);
	ceiling_lock = max(ceiling_lock-1, 0);

	//Kill the player after time has reached the limit
	if(global.stage_timer == 599999) 
	{
		_player_kill();
		is_time_over = true;
	}

	//Bottomless pit death event
	if(y > obj_camera.target_bottom && y > obj_camera.limit_bottom && !disable_death)
		_player_kill();
	
	// Reset the flags
	ledge = 0;
	pushing = 0;
	
	last_on_object = on_object;
	on_object = false;
	on_object_count = 0;
}