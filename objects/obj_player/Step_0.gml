/// @description Player scripts

	//Cancel when in debug mode
	if(debug)
	{
		exit;	
	}

	//Handle how player is controlled:
	player_control();

	//Handle player's hurt system
	player_handle_hurt()
	
	//Update player's animator
	animator_update(animator);
	
	//Handle player states
	player_states();
	
	//Player facing direction
	player_direction();
	
	//Handle partial visual rotation
	player_visual_angle();
	
	//Various hitbox cases
	player_hitbox();
	
	//Misc. player stuff
	player_misc();
	
	//Handle player's interaction with water
	player_water();
	
	//Handle player recording
	player_recorder();
