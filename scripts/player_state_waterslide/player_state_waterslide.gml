function player_state_waterslide()
{
	live_auto_call
	
	animation_play(animator, ANIM.HURT)
	
	control_lock = 2
	

	if (jump_buffer || press_action) && ground
	{
		on_terrain = false
		ground = false
		control_lock = 0
		y_speed = jump_strength * -1
		state = player_state_jump
		exit;
	}

	if (ground && y_speed >= 0) || underwater
	{
		on_terrain = false
		control_lock = 0
		state = player_state_normal
		exit;
	}
	
	var pseudo_clamp = 10 // clamp speed gain
	
	if on_terrain = true
	{
	if abs(ground_speed) > pseudo_clamp
	ground_speed = pseudo_clamp
	
	if abs(ground_speed) * -1 < (pseudo_clamp * -1)
	ground_speed = pseudo_clamp
	}
	
	
}