function player_handle_tails()
{
	animator_update(tails.animator);
	
	switch(animation_get_current_animation(animator))
	{
		case ANIM.STAND:	
		case ANIM.WAIT:
		case ANIM.LOOKUP:
		case ANIM.LOOKDOWN:
		case ANIM.PUSH:
			// Adjust his tails
			tails.visual_angle = 0;
			tails.appear = true;
			tails.facing = facing;
			
			// Adjust the offset
			tails.offset_x = 0;
			tails.offset_y = 0;
			
			// Play the normal animation
			animation_play(tails.animator, ANIM.TAILS_NORMAL);
		break;
		
		case ANIM.ROLL:
			// Make his tails appear
			tails.appear = true;
			
			// Adjust the offset
			tails.offset_x = -12 * tails.facing;
			tails.offset_y = 0;
			
			// Play the tails rolling animation
			animation_play(tails.animator, ANIM.TAILS_ROLL);
			
			// Correct speed
			var spd = ground ? ground_speed : x_speed;
			
			// Correct tails direction
			if(sign(spd) != 0) 
				tails.facing = sign(spd);
			
			// Rotating by speed
			if(state == player_state_jump || state == player_state_roll && !ground)
				tails.visual_angle = darctan2(y_speed * tails.facing, -x_speed * tails.facing) - 180;
			
			// Ground rotation
			if(state == player_state_roll && ground)
				tails.visual_angle = ground_angle;		

		break;
		
		case ANIM.SKIDTURN:
		case ANIM.SKID:
			tails.visual_angle = 0;
			tails.appear = true;
			tails.facing = facing;
			
			tails.offset_x = -4 * tails.facing;
			tails.offset_y = 6;
			
			// Specific offset for skid turn
			if(animation_is_playing(animator, ANIM.SKIDTURN))
				tails.offset_x = 0;
			
			animation_play(tails.animator, ANIM.TAILS_ROLL);
		break;
			
		case ANIM.SPINDASH:
			tails.visual_angle = 0;
			tails.appear = true;
			tails.facing = facing;

			tails.offset_x = -6 * tails.facing;
			tails.offset_y = 6;
			
			animation_play(tails.animator, ANIM.TAILS_ROLL);
		break;
			
		// TODO: LEDGE ANIMATIONS ARE NOT IN
		
		default: 
			animation_play(tails.animator, ANIM.TAILS_NORMAL);
			tails.offset_x = 0;
			tails.offset_y = 0;
			tails.appear = false;
		break;
	}
	
	// Visual angle portion
	if(global.rotation_type != 1)
	{
		tails.visual_angle_final = tails.visual_angle;
	}
	else
	{
		//Legacy angle
		tails.visual_angle_final = floor(tails.visual_angle / 45) * 45;
			
		//Limit rotation
		if(state == player_state_roll && ground && ground_angle < 45 || state == player_state_roll && ground && ground_angle > 315) 
			tails.visual_angle_final = 0;
	}
}