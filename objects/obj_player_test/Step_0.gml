	//x = mouse_x;
	//y = mouse_y;
	
	x += 1 * (Input.Right - Input.Left)
	
	var h = collision_get_height(x, y + 19);
	
	y += h;
	
	//show_debug_message(h);
	
	//image_angle = collision_get_angle(x + 9, y + 19);
	