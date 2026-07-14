	// Play music
	music_play(MUSIC.MAIN_MENU);
	
	selections = ["START GAME", "OPTIONS", "EXIT"];
	
	timer = 0;
	select = 0;
	
	text_x = array_create(array_length(selections), 0);
	text_y = array_create(array_length(selections), 0);
	text_ease_timer = array_create(array_length(selections), 1);
	
	rect_x = 0;
	rect_ease_timer = 0;
	
	bg_rect_y = CAMERA_VIEW_H / 2;
	bg_rect_timer = 1;
	
	// Because GameMaker interprets # as a newline and $ as a struct accessor, we make it BGR with 0x
	colors_light = [0x9ee8ff, 0x9ee8ff, 0xa2ffac, 0xfff49e, 0xfff49e];
	colors_dark = [0x5a2c2e, 0x5a2c2e, 0x5c311f, 0x922e1c, 0x922e1c];
	
	cursor_y = 48;
	
	selected = false;
	selected_timer = 0;
	
	different_bg = false;
	different_bg_fade = 0;