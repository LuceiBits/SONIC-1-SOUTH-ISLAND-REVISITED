function player_state_watercurrent()
{
	live_auto_call
	
	if !underwater || !place_meeting(x,y,obj_water_current)
	{
		state = player_state_waterslide
		exit
	}
	
	// Override normal movement
	control_lock = 2
	ground = false
}