function player_state_waterslide()
{
	live_auto_call
	
	animation_play(animator, ANIM.HURT)
	

	control_lock = 2
	

	if (jump_buffer || press_action) && (on_terrain || ground) && jump_lock = 0
	{
		on_terrain = false
		ground = false
		control_lock = 0
		y_speed = jump_strength * -1
		state = player_state_jump
		exit;
	}

	if (!ground && y_speed >= 0) || underwater
	{
		show_debug_message("why am i being triggered" + "| ground?: " + string(ground) + "| on_terrain?: " + string(on_terrain))
		on_terrain = false
		control_lock = 0
		state = player_state_normal
		exit;
	}
	
	var pseudo_clamp = 20 // clamp speed gain
	
	if on_terrain = true
	{
	if ground_speed > pseudo_clamp
	{
	show_debug_message("clamp speed right?")
	ground_speed = pseudo_clamp
	}
	
	if ground_speed < (pseudo_clamp * -1)
	{
	show_debug_message("clamp speed left?")
	ground_speed = pseudo_clamp * -1
	}
	}
	
	
}