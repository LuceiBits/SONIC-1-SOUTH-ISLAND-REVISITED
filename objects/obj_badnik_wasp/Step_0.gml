	// Inherit the parent event's code for the badnik
	event_inherited();
	
	depth = 0

	// Move the badnik when the wait timer is at 0
	if (waittimer == 0)
	{
		
		animation_play(animator, 0, true);
		
		if badnikdirectionPrior != badnikdirection
		badnikdirection = badnikdirectionPrior
		
		x += (badnikdirection * 4);
	}
	
	image_xscale = badnikdirection
	
	if (point_distance(x,y,obj_player.x,obj_player.y) < shootRange && waittimer = 0 && extraDelay = 0) && (y > (obj_player.y - 120) && y < (obj_player.y + 120))
	{
		
	animation_play(animator, 1, true);
		
	var timeToFire = 60
	waittimer = 70 + timeToFire
	extraDelay = 200
	alarm[0] = timeToFire
	}
	
	if waittimer > 0
	waittimer -= 1
	
	if extraDelay > 0 && waittimer = 0
	extraDelay -= 1


	
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
	//	// Add gravity
	//	//y_speed += 0.2;	
		
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

