	scale_test = 6;
	is_exiting = false;
	triggered_transition = false;
	desc_speed = -0.002;
	
	fade_in_room(2);
	
	music_play(MUSIC.TITLE);
	
	sonic_face = new animator_create();
	sonic_face_timer = 0;
	sonic_face_reset = 60;
	
	tails_face = new animator_create();
	tails_face_timer = 0;
	tails_face_reset = 60;
	
	knux_face = new animator_create();
	knux_face_timer = 0;
	knux_face_reset = 60;
	
	press_start_scale = 1;
	
	animation_add(0, spr_title_sonic_face, 4, 0, false, true);
	animation_add(1, spr_title_tails_face, 4, 0, false, true);
	animation_add(2, spr_title_knuckles_head, 4, 0, false, true);
	
	animation_play(sonic_face, 0);
	animation_play(tails_face, 1);
	animation_play(knux_face, 2);