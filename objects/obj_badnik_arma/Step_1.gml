/// @description Main player


// ACTUAL ENEMY CODE

state = player_state_roll()



	
	
	
	
	
	
	
	
	
	
	

	hitbox_top_offset = 0;
	hitbox_left_offset = 0;
	hitbox_bottom_offset = 0;
	hitbox_right_offset = 0;
	
	
	//Player input scripts
	//player_get_input();
	
	//Hande player physics values
	player_handle_physics();
	
	//prevent player for dieing in the bonus stage

	
	//check if player should be able to turn super
	
	//Handle invincibility and speed shoes
	
	//Step movement for sticking on the collision
	steps = min(1 + abs(round(x_speed / PLAYER_STEPS_AMOUNT)) + abs(round(y_speed / PLAYER_STEPS_AMOUNT)), PLAYER_MAX_STEPS);
	
	//Cancel when in debug mode

	//Include step movement
	repeat(steps)
	{
		//Handle player movement:
		player_movement();
		
		//Handle how player changes floor modes:
		if(!PLAYER_ALT_COLLISION_MODE)
			player_mode();
		
		//Handle player terrain collision:
		player_collision();
	}
	
	//Handle how player is controlled:
	player_control();

	//Update player's animator
	animator_update(animator);
	
	//Handle player states
	//player_states();
		
	//Player facing direction
	player_direction();
	
	//Handle partial visual rotation
	//player_visual_angle();
	
	//Various hitbox cases
	arma_hitbox();
	
	//Misc. player stuff
	arma_misc();
	
	//Handle player's interaction with water
	player_water();
	
	// Update the recorder
	//instance_recorder_update(recorder);