function player_shield_fire()
{
	if(shield_state == 0)
	{
		with(shield_obj)
		{
			// Play the shield animation
			animation_play(animator, SHIELD_ANIM.FIRE_IDLE);	
		
			// Get the shiled animation frame
			var frame = animation_get_frame(animator);
		
			// Correct the depth
			depth = other.depth + ((frame % 2) ? -10 : 10);
			
			// Correct the scaling
			image_xscale = 1;
		}
		
		if(character == CHAR_SONIC && press_action && state == player_state_jump && !ground && !invincible)
		{
			//Dash the player
			x_speed = 8 * facing;
			y_speed = 0;
		
			//The camera lag
			camera_set_lag(12);
		
			//Switch shield state
			shield_state = 1;
		
			//Play sound
			sound_play(sfx_fire_dash);		
		}
	}
	else
	{
		// Update the animation and depth
		with(shield_obj)
		{
			animation_play(animator, SHIELD_ANIM.FIRE_DASH);
			depth = other.depth - 10;
			
			// Correct the scaling depending on movement
			if(sign(other.x_speed) != 0)
				image_xscale = sign(other.x_speed);
		}
		
		// Reset the state
		if(ground || state != player_state_jump)
			shield_state = 0;
	}
	
	// No more shield underwater
	if(underwater)
		shield = SHIELD.NONE;
}