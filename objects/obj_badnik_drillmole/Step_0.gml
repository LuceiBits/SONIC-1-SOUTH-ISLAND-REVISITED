	// Inherit the parent event's code for the badnik
	event_inherited();
	
	// Gravity
	if grounded = false
	y_speed += 0.18; 

	// Change some values
	x += x_speed;
	y += y_speed;
	
	
	// Check for collision on ground
		var g = 80 // range it should jump at
		var c = point_distance(x,y,obj_player.x,obj_player.y)
		if(c < g) && grounded = true && drill_jumped = false
		{
			animation_play(animator, 1, true);
			drill_jumped = true
			grounded = false
			x_speed = 1 * (image_xscale);
			y_speed = -5;
			check_buffer = 10
			//animator_reset(animator);
			
			// Snap it to the floor
			
			
			// Play spring sound when on screen
			if(instance_origin_on_screen(32, 32))
			{
				var jump_sound = sound_play(sfx_spring);
				audio_sound_pitch(jump_sound, 1.5);
			}
		}
	
	
var d = collision_get_distance(x, y, COLLISION_MODE.FLOOR, PLANE.A, true)

	if drill_jumped = true && (d < 0) && check_buffer <= 0
	{
	animation_play(animator, 2, true);
	grounded = true
	y += d;
	y_speed = 0
	}

	// Visuals etc
	if x_speed != 0
	image_xscale = sign(x_speed); // Point badnik in the direction of the speed in which it's going
	animator_update(animator);
	
	if check_buffer > 0
	check_buffer -= 1