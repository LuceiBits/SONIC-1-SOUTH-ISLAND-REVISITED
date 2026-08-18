function player_state_watercurrent()
{
	live_auto_call
	if obj_player.state = player_state_death
	exit;
	
	if !animation_is_playing(animator,ANIM.WATER_TUNNEL)
	animation_play(animator,ANIM.WATER_TUNNEL)
	
	if !underwater || !place_meeting(x,y,obj_water_current)
	{
		state = player_state_waterslide
		exit
	}
	
	// Override normal movement
	control_lock = 2
	ground = false
}