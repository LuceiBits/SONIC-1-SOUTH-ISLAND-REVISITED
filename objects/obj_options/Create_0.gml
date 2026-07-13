	menu = obj_main_menu;
	
	option_name = ["WINDOW SIZE", "MUSIC VOLUME", "SOUND VOLUME"];
	option_variables = array_create(array_length(option_name), 0);
	option_offset = array_create(array_length(option_name), 256);
	option_ease = array_create(array_length(option_name), 1);
	
	timer = 0;
	
	select = 0;
	cursor_y = (CAMERA_VIEW_H / 2) - 64 + (24 * 0);
	cursor_size = 0;
	
	transition_offset = 256;
	transition_timer = 1;
	
	leave = false;
	returning = false;
	return_timer = 0;