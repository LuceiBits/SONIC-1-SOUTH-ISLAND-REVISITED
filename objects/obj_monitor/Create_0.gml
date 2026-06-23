/// @description Values
	destroyed = false;
	ground = true;
	x_speed = 0;
	y_speed = 0;
	monitor_icon = spr_monitor_icon_10ring;
	culling = true;
	
	instance_register_culling();
	
	// This has to be moved later
	enum MONITOR
	{
		RINGS,
		SHIELD,
		FIRE_SHIELD,
		ELECTRIC_SHIELD,
		BUBBLE_SHIELD,
		INVINCIBLE,
		SPEED_SHOES,
		EXTRA_LIFE,
		EGGMAN,
		COMBINE_RING
	}
	
	if (!instance_exists(obj_bonus_level)) 
	{
		if (global.store_object_state[| id]) 
		{
			destroyed = true
			ground = false
		}
	}