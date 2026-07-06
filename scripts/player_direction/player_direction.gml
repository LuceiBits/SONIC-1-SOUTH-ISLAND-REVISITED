function player_direction(){
	//Get input difference:
	var i = hold_right - hold_left;
	
	if(direction_allow)
	{
		//On ground direction:
		if(ground)
		{
			//Change direction depending on the ground speed:
			if(i != 0 && sign(ground_speed) = i && control_lock = 0) facing = sign(i);
		}else
		//Airborn events:
		{
			//Change direction depending on input press:
			if(i != 0) facing = i;
		}
	}
	
	image_xscale = facing;
}