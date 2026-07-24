    // Decrement flashing timer
	if(flash_hold_timer > 0)
		flash_hold_timer--;
    
	image_yscale = math_approach(image_yscale, level_target, rise_speed);
    
    //Update Position y
    pos_y = bbox_top + 16;