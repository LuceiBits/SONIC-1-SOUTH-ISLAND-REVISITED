/// @description Scripts
	animator_update(animator);

	//Change animation speed
	if(animation_get_speed(animator) != (!triggered ? 0 : 0.4))
		animation_set_speed(animator, !triggered ? 0 : 0.4);
	
	//Subtract delay timer
	delay = max(delay-1, 0);
	
	//Stop executing if theres delay
	if(delay > 0) exit;
	
	//Update position
	x += accel[animal_type] * facing;
	y += y_speed;
	y_speed += grav;
	landed = false;
	
	//Handle collision
	var c = collision_get_distance(x, y + 8, CMODE_FLOOR, PLANE_A, true)
	
	if(c < 0 && y_speed >= 0)
	{
		if(!triggered)
		{
			//Change direction
			if(obj_player.x != x) facing = sign(x-obj_player.x);
			image_xscale = facing;
			
			//Change gravity based on animal type
			grav = grav_arr[animal_type];
			
			//Its triggered
			triggered = true;	
		}
		
		y += c;	
		landed = true;
	}
	
	if(landed)
	{
		y_speed = -jump_force[animal_type];
	}
	
	//Capsule event
	if(instance_exists(obj_capsule))
	{
		with(obj_capsule)
		{
			if(instance_on_screen())	
			{
				if(other.delay = 0)
				{
					other.depth = depth - 10;	
				}
			}
		}
	}
	
	//Destroy offscreen
	if(!instance_on_screen(32, 32)) 
		instance_destroy();