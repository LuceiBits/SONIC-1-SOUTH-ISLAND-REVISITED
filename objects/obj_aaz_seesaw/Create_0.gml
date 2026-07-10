/// @description Values
	left_platform_x = x - 32;
	left_platform_y = y + 64;
	
	right_platform_x = x + 32;
	right_platform_y = y + 64;
	
	weight_x = x + 32;
	weight_y = y + 64;
	weight_grav = 0;
	weight_ground = true;
	weight_landed = false;
	
	bouncing = false
	weight = -16;
	right_override = false
	weightoff = false
	stepping_side = 1;
	
	// Register the object for culling
	var box = _instance_make_hitbox(id);
	box = _instance_orient_hitbox(id, box);
	
	// Reseting events
	on_reset = function()
	{
		weight_x = x + 32;
		weight_y = y + 64;
		weight_grav = 0;
		weight_ground = true;
		weight_landed = false;
	
		bouncing = false
		weight = -16;
		right_override = false
		weightoff = false
		stepping_side = 1;
	}
	
	instance_register_culling(box, on_reset);
	
	yscale = image_yscale;
	image_yscale = 1;
	
	depth = player_find(0).depth + 10;
	