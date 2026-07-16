function player_shield_electric()
{
	with(shield_obj)
	{
		// Play the shield animation
		animation_play(animator, SHIELD_ANIM.ELECTRIC_IDLE);	
		
		// Order change
		if(animation_get_frame(animator) <= 12 || animation_get_frame(animator) >= 20) 
		{
			depth = other.depth - 10;
		}
		else	// In the back
		{
			depth = other.depth + 10;
		}
	}
	
	// Double jump
	if(shield_state == 0 && press_action && !invincible && state == player_state_jump)
	{
		//Player double jump
		y_speed = -5.5;
		
		//Switch shield state
		shield_state = 1;
		
		//Play sound
		sound_play(sfx_electric_shield_jump);
		
		//Make shield sparkles
		for (var i = 0; i < 4; ++i) 
		    instance_create_particle(x, y, spr_electric_sparks, 1, depth + 1, 2 * dsin(45 + (90 * i)), 2 * dcos(45 + (90 * i)))
	}
	
	// Reset the state when grounded
	if(shield_state == 1 && (ground || state != player_state_jump))
		shield_state = 0;
		
	// Ring magnet
	with(obj_ring)
	{
		if(distance_to_object(other) < 64 && !magnet)
		{
			_instance_remove_attached();
			magnet = true;
		}
	}
}