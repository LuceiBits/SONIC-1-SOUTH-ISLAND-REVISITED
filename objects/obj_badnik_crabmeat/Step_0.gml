// Inherit the parent event's code for the badnik
event_inherited();

switch state
{
	case 0: // Walking
	x += badnikdirection * spx(128)
	animation_play(animator, 0, true);
	
	if timer = 0
	{
		animation_play(animator, 1);
		state++
		timer = 90
	}
	break;
	case 1: // Before Shooting 
	if timer = 0
	{
		if !shot
		{
			shot = true
			timer = 0
			state++
		}
		else
		{
			animation_play(animator, 2);
			instance_create_bullet(spr_projectile_red, 0, x + 16, y, ,  1, -4, spx(56))
			instance_create_bullet(spr_projectile_red, 0, x - 16, y, , -1, -4, spx(56))
			state++
			timer = 60
		}
	}
	break;
	case 2: // After Shooting
	
	if timer = 0
	{
		badnikdirection *= -1
		state = 0
		timer = 128
	}
	break;
}

// Vertical movement
y += y_speed;

// Animate the badnik
animator_update(animator);
	
// Scale badnik in accordance to its direction
image_xscale = badnikdirection
	
// Collision checks
var fcheck = collision_get_distance(x, y + 15, COLLISION_MODE.FLOOR, PLANE.A, true);
var ledgecheck = collision_get_distance(x + 8 * badnikdirection, y + 15, COLLISION_MODE.FLOOR, PLANE.A, true);
var wallcheck = collision_get_distance(x + 12 * badnikdirection, y, badnikdirection ? COLLISION_MODE.LEFT_WALL : COLLISION_MODE.RIGHT_WALL, PLANE.A, true);
	
// Grounded state
if(grounded)
{	
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
		if ledgecheck > 14//if(ledgecheck > 14 && waittimer == 0)
		{
			//state = 2
			//timer = 60
			badnikdirection *= -1
		}
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
	/*
	if(waittimer == 0)
		waittimer = 60;
		*/
	//state = 2
	//timer = 60
	badnikdirection *= -1
		
	// Snap the badnik to the wall
	x += wallcheck * badnikdirection;
}

if grounded
	timer = max(timer - 1,0)