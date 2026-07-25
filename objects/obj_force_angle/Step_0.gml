/// @description Script
	
	if(player_collide_object(COLLISION.MAIN))
	{
		//Force angle
		obj_player.ground_angle = target_angle;
		with(obj_player)
		{
			player_mode();	
		}
	}