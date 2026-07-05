/// @description Pre-main player
	//Change character
	character = global.character;
	
	//Tails object
	if(character = CHAR_TAILS && !instance_exists(obj_tails_object)) instance_create_depth(x, y, depth + 1, obj_tails_object)
	if(character != CHAR_TAILS)instance_destroy(obj_tails_object);
	
	//Hitbox variables
	hitbox_top_offset = 0;
	hitbox_left_offset = 0;
	hitbox_bottom_offset = 0;
	hitbox_right_offset = 0;
	
	//Player input scripts
	player_get_input();
	
	//Hande player physics values
	player_handle_physics();
	
	//prevent player for dieing in the bonus stage
	if (instance_exists(obj_bonus_level)) 
	{
		disable_death = true	
	}
	
	//check if player should be able to turn super
	allow_super = true
	if (input_disable || obj_level.disable_timer || instance_exists(obj_bonus_level) || instance_exists(par_shield))
	{
		allow_super = false	
	}
	
	//Handle invincibility and speed shoes
	player_inv_speed();
	
	//Step movement for sticking on the collision
	steps = min(1 + abs(round(x_speed / PLAYER_STEPS_AMOUNT)) + abs(round(y_speed / PLAYER_STEPS_AMOUNT)), PLAYER_MAX_STEPS);
	
	//Cancel when in debug mode
	if(debug)
	{
		player_debug();
		exit;	
	}

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
	
	// Reset flags
	on_object = false;