	// Get the player object
	var player = player_find(0);
	
	// Entering the S tube area
	if(!player.force_roll && !triggered && player_collide_object())
	{
		player.force_roll = true;
		triggered = true;
		
		// Make the player roll
		with(player)
		{
			if(state != player_state_roll)
			{
				state = player_state_roll;
				animation_play(animator, ANIM.ROLL);
				sound_play(sfx_roll);
			}
		}
	}
	
	// Exiting the S Tube area
	if(player.force_roll && triggered && !player_collide_object())
	{
		player.force_roll = false;
		triggered = false;
	}