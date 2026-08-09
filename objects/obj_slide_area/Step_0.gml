if player_collide_object(,COLLISION.MAIN) && obj_player.ground && !obj_player.underwater
{
	with obj_player
	{
		if !place_meeting(x,y,obj_slide_eject)
		{
		on_terrain = true
		state = player_state_waterslide
		if image_xscale != sign(other.image_xscale) && other.image_xscale != 0
			{
			ground_speed = abs(ground_speed) * sign(other.image_xscale)
			image_xscale = sign(other.image_xscale)
			}
			else if abs(ground < 8)
			{
			ground_speed += 0.08 * sign(other.image_xscale)
			}
		control_lock = 16
		if ground_speed != 0
			facing = sign(ground_speed)
		}
	}
}