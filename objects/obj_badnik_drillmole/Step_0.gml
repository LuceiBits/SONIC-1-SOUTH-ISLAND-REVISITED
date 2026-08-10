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
		if ((c < g) && grounded = true && drill_jumped = false) || (drill_jumped = false && grounded = false)
		{
			animation_play(animator, 1, true);
			drill_jumped = true
			grounded = false
			x_speed = 1 * (image_xscale);
			y_speed = -6;
			y += 25
			check_buffer = 20
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
	
	if grounded = false
	{
		if obj_player.x > x 
		{
		image_xscale = 1
		show_debug_message("FACE PLAYER ON RIGHT")
		}

		if obj_player.x < x 
		{
		image_xscale = -1
		show_debug_message("FACE PLAYER ON LEFT")
		}
	}
	
	grounded = true
	y += d;
	y_speed = 0
	}
	
	if grounded && d > 0 && check_buffer <= 0
	{
	grounded = false
	drill_jumped = false
	check_buffer = 0
	}

	// Visuals etc
	//if x_speed != 0
	//image_xscale = sign(x_speed); // Point badnik in the direction of the speed in which it's going
	animator_update(animator);
	
	if check_buffer > 0
	check_buffer -= 1
	
	var badnikdirection = image_xscale
	
	var wallcheck = collision_get_distance(x + 12 * badnikdirection, y, badnikdirection ? COLLISION_MODE.LEFT_WALL : COLLISION_MODE.RIGHT_WALL, PLANE.A, true);
	
	if grounded && drill_jumped = true && check_buffer <= 0
	{
		if(wallcheck < 0)
	{
		// Otherwise make it wait
		//if(waittimer == 0)
		//	waittimer = 60;
		
		image_xscale = badnikdirection * -1
		

		// Snap the badnik to the wall
		x += wallcheck * badnikdirection;
	}
	}
	
	if grounded && drill_jumped = true && check_buffer <= 0
	x_speed = image_xscale