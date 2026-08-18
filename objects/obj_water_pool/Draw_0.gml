/// @description Draw water 
    
    //Draw basic rectangle with blendmode
    draw_set_color(water_color);
    gpu_set_blendmode(bm_subtract);
    draw_rectangle(x, pos_y, bbox_right, y, false);
    gpu_set_blendmode(bm_normal);
    draw_set_color(c_white);
	
	if(flash_hold_timer > 0 && WATER_FLASH)
	{
		draw_set_color(WATER_FLASH_COLOR);
		draw_rectangle(x, pos_y, bbox_right, y, false);
		draw_set_color(c_white);
	}
	
	//IMPORTANT NOTE!!
	//Enable this code if you wanna use shaders for color replacing instead of blend modes
	//You can either use palette_swap or set_color_grading
	
	/*
	//Draw whole ass water
	if(!surface_exists(surf)) surf = surface_create(global.window_width, global.window_height);
	
	//Draw shit in this
	surface_set_target(surf);
	
	//Draw tint surface
	gpu_set_blendenable(false);
	surface_copy(surf, 0, 0, application_surface);
	effect_set_color_grading(yourlut, 17);

	//Done
	surface_reset_target();

	//Draw surface
	draw_surface_part(surf, 0,y-cy,426,cy,cx+64, y);
	shader_reset();
	gpu_set_blendenable(true);
	*/
    
	//Drawing the water
	switch draw_side
	{
		case "Left":
			draw_sprite_ext(spr_water, FRAME_TIMER * anim_speed, bbox_left, bbox_bottom, sprite_height/spr_height, 1, 90, c_white, 1);
		break;
		case "Bottom":
			draw_sprite_ext(spr_water, FRAME_TIMER * anim_speed, x, bbox_bottom, sprite_width/spr_width, -1, 0, c_white, 1);
		break;
		case "Top":
			draw_sprite_ext(spr_water, FRAME_TIMER * anim_speed, x, pos_y, sprite_width/spr_width, 1, 0, c_white, 1);
		break;
		case "Right":
			draw_sprite_ext(spr_water, FRAME_TIMER * anim_speed, bbox_right, pos_y, sprite_height/spr_height, 1, -90, c_white, 1);
		break;
	}
    