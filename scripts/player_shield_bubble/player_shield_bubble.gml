function player_shield_bubble()
{
	if(shield_state == 0)
	{
		with(shield_obj)
		{
			// Play the shield animation
			if(!animation_is_playing(animator, SHIELD_ANIM.BUBBLE_BOUNCE_OUT) || animation_is_playing(animator, SHIELD_ANIM.BUBBLE_BOUNCE_OUT) && animation_has_finished(animator))
				animation_play(animator, SHIELD_ANIM.BUBBLE_IDLE);	
		
			// Order change
			depth = other.depth - 10;


		}
	
		// Shield action
		if(press_action && !invincible && state == player_state_jump)
		{
			//Player go down
			x_speed = 0;
			y_speed = 8;
		
			//Switch shield state
			shield_state = 1;
		
			//Play sound
			sound_play(sfx_bubble_jump);
			
			// Play the animation
			with(shield_obj)
				animation_play(animator, SHIELD_ANIM.BUBBLE_BOUNCE_IN);
		}
	}
	
	// Reset the state when grounded
	if(shield_state == 1 && (ground || y_speed < 0 || invincible))
	{
		//Player bounce
		if(ground)
		{
			x_speed = (dsin(ground_speed) * dcos(ground_angle) +  -7.5 / (1 + underwater)) * dsin(ground_angle);
            y_speed = (dcos(ground_speed) * dsin(ground_angle) +  -7.5 / (1 + underwater)) * dcos(ground_angle);
			ground = false;
			state = player_state_jump;
			jump_flag = true;
			
			//Play sound
			sound_play(sfx_bubble_jump);
			
			with(shield_obj)
				animation_play(animator, SHIELD_ANIM.BUBBLE_BOUNCE_OUT);
		}
		
		sound_play(sfx_bubble_jump);
		shield_state = 0;
	}
}