	// Inherit the parent event's code for the badnik
	event_inherited();
	
	depth = 0

	// Move the badnik when the wait timer is at 0
	//if (waittimer == 0)
	//{
	//	//x += (badnikdirection * 4);
	//}

		if y >= ystart && waittimer = 0 
		{
		y_speed = -7
		waittimer = 5
		}
	
		y += y_speed
	
		// fake ahh gravity
		y_speed += 0.16;	


	//else // Lucei Fishbone Movement
	//{
	//	if (waittimer != 0)
	//	{
	//		x += (badnikdirection * 1);
	//	}
	//	else
	//	{
	//	badnikdirection *= -1	
	//	waittimer = 200
	//	}
	//}
	
	
		if waittimer > 0
		waittimer -= 1
	
	// Vertical movement
	//y += y_speed;

	// Animate the badnik
	animator_update(animator);
	
	// Scale badnik in accordance to its direction
	image_xscale = badnikdirection
	
	// Collision checks
//	var fcheck = collision_get_distance(x, y + 15, COLLISION_MODE.FLOOR, PLANE.A, true);
	//var ledgecheck = collision_get_distance(x + 8 * badnikdirection, y + 15, COLLISION_MODE.FLOOR, PLANE.A, true);
//	var wallcheck = collision_get_distance(x + 12 * badnikdirection, y, badnikdirection ? COLLISION_MODE.LEFT_WALL : COLLISION_MODE.RIGHT_WALL, PLANE.A, true);
	
	// Grounded state
	//if(grounded)
	//{	
	//	// Detach if there's no ground below
	//	if(fcheck > 14)
	//	{
	//		grounded = false;	
	//	}
	//	else
	//	{
	//		// Attach to the floor
	//		y += fcheck;
			
	//		// If the badnik is on the ledge, turn it
	//		if(ledgecheck > 14 && waittimer == 0)
	//			waittimer = 60;
	//	}
		
	//	// Reset the y speed just in case
	//	y_speed = 0;
	//}
	//else
	//{

		
	//	// If the ground is detected, ground the badnik
	//	if(fcheck < 0)
	//	{
	//		y += fcheck;
	//		grounded = true;
	//	}
	//}
	
	// Wall checks
	//if(wallcheck < 0)
	//{
	//	// Otherwise make it wait
	//	if(waittimer == 0)
	//		waittimer = 60;
		
	//	// Snap the badnik to the wall
	//	x += wallcheck * badnikdirection;
	//}
	
	//// Check if waiting timer is 1 and turn the badnik
	//if(waittimer == 1)
	//	badnikdirection *= -1;
	
	// Decrease the waiting timer afterward
	//if(grounded)
	//	waittimer = max(waittimer - 1,0);

