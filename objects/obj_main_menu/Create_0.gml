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
	
	cursor_y = 48;