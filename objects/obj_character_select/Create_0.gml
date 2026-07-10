	menu = obj_main_menu;
	
	sprites = [spr_sonic_victory, spr_tails_victory, spr_knuckles_victory];
	char_names = ["SONIC", "TAILS", "KNUCKLES"];
	char_y = array_create(3, 0);
	select = 0;
	
	transition_offset = 256;
	transition_timer = 1;
	
	leave = false;
	returning = false;
	return_timer = 0;