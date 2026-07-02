/// @description Script
	//Play the animation
	animator_update(animator);
	animation_play(animator, type);
	
	//Add timer
	timer++;

	//Get screen position
	var cx = camera_get_view_x(view_camera[view_current]);
	var cy = camera_get_view_y(view_camera[view_current]);
	
	//Position the bubble 
	if(!animation_has_finished(animator)){
		//Movement
		y -= 0.5;
		x = xstart + 3 * dsin(angle)
	
		//Add and modulate angle
		angle = (angle + 2) mod 360;
		
		// Get the screen values
		screen_x = x - cx;	
		screen_y = y - cy;	
	}
	else
	{
		x = cx + screen_x;
		y = cy + screen_y;
	}
	
	//Ded
	if(timer > 110) 
		instance_destroy();