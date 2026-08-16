/// @description Values
	spr_width = sprite_get_width(sprite_index);
    spr_height = sprite_get_height(sprite_index);
	screen_width = (global.window_width)/sprite_get_width(sprite_index);
	surf = surface_create(global.window_width, global.window_height);
	
	//Change animation speed
	anim_speed = 0.15;
	
	flash_hold_timer = 0;
	level_target = ystart;
	rise_speed = 2;

	
	if global.water_level_store != -4
	{
	y = global.water_level_store
	level_target = y
	}