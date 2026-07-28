	/// @description Boss Movement
	y = target_y + 8 * dsin(orbit_time);
	
	orbit_time += 2;
	
	if(timer > 60)
	{
		x = xstart + 128 * dsin(move_time);
		move_time += move_spd;
		
		move_spd = math_approach(move_spd, 1, 0.02);
	}