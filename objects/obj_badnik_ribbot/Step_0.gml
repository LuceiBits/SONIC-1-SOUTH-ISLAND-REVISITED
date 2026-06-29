	// Inherit the parent event's code for the badnik
	instance_act_badnik();

	// Change some values
	x += x_speed;
	y += y_speed;
	
	// Gravity
	y_speed += 0.18; 
	
	// Check for collision on ground
	if(y_speed > 0)
	{
		var c = collision_get_distance(x, y, CMODE_FLOOR, PLANE_A, true)
		if(c < 0)
		{
			x_speed *= -1;
			y_speed = -5;
			badnikframe = 0
			
			// Snap it to the floor
			y += c;
			
			// Play spring sound ONLY when on screen
			if (on_screen()) 
				play_sound(sfx_spring);
		}
	}

	// Visuals etc
	image_xscale = sign(x_speed); // Point badnik in the direction of the speed in which it's going
	badnikframe += 0.2;
	image_index = min(floor(badnikframe),2); //Limit until 2 for the frame