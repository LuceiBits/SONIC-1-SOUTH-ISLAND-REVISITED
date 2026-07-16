/// @description Script	
	//Reset the flag
	collision_flag = true;
	
	switch(breakable_type)
	{
		case 0:
		//Change collision flag
		if(obj_player.state == player_state_roll && abs(obj_player.ground_speed) >= 1 && obj_player.ground || obj_player.state = player_state_spindash || obj_player.character == CHAR_KNUX)
		{
		    if(obj_player.character == CHAR_KNUX && knuckles_wall)
			{
				collision_flag = false;	
				
		}else if (knuckles_wall = false)
			{
			
				collision_flag = false;	
			}
		}	
	
		//If so disable collision when player hits the wall
		if(obj_player.shield == SHIELD.FIRE && obj_player.shield_state == 1) 
		{
			collision_flag = false;
		}
		break;
		
		case 1:
		case 2:
			if(obj_player.state != player_state_spindash && obj_player.attacking && obj_player.y_speed >= 0)
			{
				collision_flag = false;	
			}
		break;
		case 3:
			if(obj_player.y_speed < 0)
			{
				collision_flag = false;	
			}
		break;	
	}
	
	if(collision_flag)
		player_act_solid()
		
	//Destroy the wall
	if(player_collide_object())
	{
		switch(breakable_type)
		{
			case 1:
				obj_player.y_speed = abs(obj_player.y_speed) * -1;
			break;
			
			case 2:
				obj_player.y_speed = 0;
			break;
		}
		instance_destroy();	
	}
