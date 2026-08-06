if player_collide_object(,COLLISION.MAIN) && obj_player.ground
{
	with obj_player
	{
		state = player_state_waterslide
		ground_speed += 0.08 * sign(other.image_xscale)
		control_lock = 16
		if ground_speed != 0
			facing = sign(ground_speed)
	}
}