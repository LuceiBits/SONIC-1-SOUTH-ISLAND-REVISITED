if player_collide_object(,COLLISION.MAIN) && obj_player.ground && !obj_player.underwater
{
	with obj_player
	{
		if state != player_state_jump
		{
		on_terrain = true
		state = player_state_waterslide
		if image_xscale != other.image_xscale
			{
			ground_speed += 0.16 * sign(other.image_xscale)
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