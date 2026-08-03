// Inherit the parent event's code for the badnik
event_inherited();
	
depth = 0

if point_distance(x,y,obj_player.x,obj_player.y) < 180 && (y > (obj_player.y - 120) && y < (obj_player.y + 120))
inRange = true

if inRange = true && waittimer = 0 && fired = false
{
	if image_alpha < 1 && madeVisible = false
	image_alpha += 0.08

	if image_alpha = 1 && madeVisible = false
	{
		waittimer = 50
		madeVisible = true
		alarm[0] = 10
	}
}

if waittimer > 0
	waittimer -= 1

image_xscale = badnikdirection
	
// Collision checks
	
if fired = true
{
	y += y_speed;
		
	
	var fcheck = collision_get_distance(x, y + 15, COLLISION_MODE.FLOOR, PLANE.A, true);
	var ledgecheck = collision_get_distance(x + 8 * badnikdirection, y + 15, COLLISION_MODE.FLOOR, PLANE.A, true);
	var wallcheck = collision_get_distance(x + 12 * badnikdirection, y, badnikdirection ? COLLISION_MODE.LEFT_WALL : COLLISION_MODE.RIGHT_WALL, PLANE.A, true);
	
	// Grounded state
	if(grounded)
	{	
		animation_play(animator, 1);
		
		if (fired = true)
			x += badnikdirection * 3;
	
		// Detach if there's no ground below
		if(fcheck > 14)
		{
			grounded = false;	
		}
		else
		{
			// Attach to the floor
			y += fcheck;
			
			// If the badnik is on the ledge, turn it
			if(ledgecheck > 14 && waittimer == 0)
				waittimer = 60;
		}
		
		// Reset the y speed just in case
		y_speed = 0;
	}
	else
	{
		// Add gravity
		y_speed += 0.2;	
		
		// If the ground is detected, ground the badnik
		if(fcheck < 0)
		{
			y += fcheck;
			grounded = true;
		}
	}
	
	// Wall checks
	if(wallcheck < 0)
	{
		// Otherwise make it wait
		if(waittimer == 0)
			waittimer = 60;
		
		// Snap the badnik to the wall
		x += wallcheck * badnikdirection;
	}
	
}
	
animator_update(animator);

