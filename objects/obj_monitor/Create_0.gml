/// @description Values
	destroyed = false;
	ground = true;
	x_speed = 0;
	y_speed = 0;
	monitor_icon = spr_monitor_icon_10ring;
	culling = true;
	touched = false
	
	instance_register_culling();

	if (!instance_exists(obj_bonus_cont)) 
	{
		if (global.store_object_state[| id]) 
		{
			destroyed = true
			ground = false
		}
	}