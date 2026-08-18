if player_collide_object(,COLLISION.MAIN) && obj_player.ground && !obj_player.underwater
{
	with obj_player
	{
		if !place_meeting(x,y,obj_slide_eject)
		{
			on_terrain = true
			
			if facing != image_xscale
			facing = image_xscale
			
			if facing != sign(other.image_xscale) && control_lock = 0
			{
				if abs(ground_speed) > 12
				ground_speed = 12 * sign(ground_speed)
				
				ground_speed = abs(ground_speed) * sign(other.image_xscale)
				facing = sign(other.image_xscale)
				show_debug_message("opposing direction reversal")
			}
			else if abs(ground_speed) < 8
			ground_speed = 8 * sign(other.image_xscale)
			
			ground_speed += 0.08 * sign(other.image_xscale)

			if state != player_state_waterslide
			jump_lock = 8


			state = player_state_waterslide
			
			control_lock = 2
			
			if ground_speed != 0
				facing = sign(ground_speed)
		}
	}
}