/// @description Scripts
	
	//Update y position
	y += y_speed;
		
	//Stop animation
	image_speed = 0;
	image_index = 0;
		
	//Speed friction
	y_speed = min(y_speed + 0.09375, 0)

	//Add timer
	timer++;
	
	//Destroy
	if(timer == 50)
	{
		event_user(0);
		
		if(global.chaotix_monitors) 
			effect_create_dust(1);
		else
			instance_destroy();
	}