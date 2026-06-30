/// @description Values
	triggered = false;
	inside_trigger = false;
	spring_power = 10;
	
	//Create the new animator
	animator = new animator_create();

	//Different spring types
	switch(spring_type)
	{
		case "Yellow":
			animation_add(0, spr_spring_diagonal_yellow, 0.6, 0, false);
			spring_power = 7;
		break;
		
		case "Red":
			animation_add(0, spr_spring_diagonal_red, 0.6, 0, false);
			spring_power = 11;
		break;
	}
	
	//Play the first animation
	animation_play(animator, 0)
	
	// Register the object for culling
	instance_register_culling();