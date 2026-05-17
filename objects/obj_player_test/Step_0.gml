	x += x_speed;
	y += y_speed;
	
	image_angle = 0;
	
	if(!ground)
	{
		y_speed += 0.2;
		h = collision_get_height(x, y + 19, CMODE_FLOOR);
		
		if(h < 0)
		{
			y += h;
			image_angle = collision_get_angle(x, y + 19, CMODE_FLOOR);
			
			y_speed = 0;
			ground = true;
		}
	}
	else
	{
		var xdir = mode == 1 || mode == 3
		var ydir = mode == 0 || mode == 2
		
		h = collision_get_height(x + 19 * xdir, y + 19 * ydir, mode);	
		
		x += h * (mode == 1);
		y += h * (mode == 0);
	
		angle = collision_get_angle(x + 19 * xdir, y + 19 * ydir, mode);
		
		if(angle > 45)
			mode = 1;
		
		image_angle = angle;
		
		
	}
	
	
	
	x_speed = 2 * (Input.Right - Input.Left);
	show_debug_message(mode)