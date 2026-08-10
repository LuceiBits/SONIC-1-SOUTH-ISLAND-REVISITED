// Inherit the parent event's code for the badnik
event_inherited();

if y > obj_water.bbox_top
	underwater = true
else
	underwater = false

// Collision checks
var fcheck = collision_get_distance(x, y + 15, COLLISION_MODE.FLOOR, PLANE.A, true);
//var ccheck = collision_get_distance(x, y - 15, COLLISION_MODE.CEILING, PLANE.A, true);
var ledgecheck = collision_get_distance(x + 8 * badnikdirection, y + 15, COLLISION_MODE.FLOOR, PLANE.A, true);
var wallcheck = collision_get_distance(x + 12 * badnikdirection, y, badnikdirection ? COLLISION_MODE.LEFT_WALL : COLLISION_MODE.RIGHT_WALL, PLANE.A, true);

x += x_speed;
y += y_speed;

if underwater
{
	y_speed = 0
	
	x_speed = badnikdirection/2
	
	//if y != ystart
	//	y = math_approach(y, ystart, 0.5)
	
	image_yscale = 1
	animation_set_speed(animator, 1)
}
else
{
	// Gravity
	y_speed += 0.18; 
	
	// Check for collision on ground
	if(y_speed > 0)
	{
		//var c = collision_get_distance(x, y, COLLISION_MODE.FLOOR, PLANE.A, true)
		if(fcheck < 0)
		{
			x_speed *= -1;
			y_speed = -3
			animator_reset(animator);
			
			// Snap it to the floor
			y += fcheck;
			
			// Play spring sound when on screen
			if(instance_origin_on_screen(32, 32))
			{
				var jump_sound = sound_play(sfx_spring);
				audio_sound_pitch(jump_sound, 1.5);
			}
		}
	}
	
	image_yscale = -1
	animation_set_speed(animator, 0.3)
}

// Wall checks
if(wallcheck < 0)
{
	badnikdirection *= -1
	// Snap the badnik to the wall
	x += wallcheck * badnikdirection;
}

if x_speed != 0
	image_xscale = sign(x_speed);

animator_update(animator);