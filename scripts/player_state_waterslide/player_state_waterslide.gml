function player_state_waterslide()
{
	live_auto_call
	
	animation_play(animator, ANIM.HURT)
	
	if (ground && y_speed >= 0) || underwater
	{
		control_lock = 0
		state = player_state_normal
	}
}