	// Decrement flashing timer
	if(flash_hold_timer > 0)
		flash_hold_timer--;
		
	y = math_approach(y, level_target, rise_speed);
	
	if y != level_target
	obj_camera.camera_shake = 1
	
