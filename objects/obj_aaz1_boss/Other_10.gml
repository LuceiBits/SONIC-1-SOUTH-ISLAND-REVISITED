	/// @description Boss Entering
	y = math_approach(y, target_y, 1);
	
	if(y == target_y)
	{
		boss_state = AAZ1_BSTATE.MOVE;	
		timer = 0;
	}