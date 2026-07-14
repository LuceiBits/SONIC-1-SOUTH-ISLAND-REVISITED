	/// @description Values
	delay = 0
	timer = 0

	options_array = ["CONTINUE", "RESTART", "EXIT"];
	allow_restart = true;

	background_rect_y = 0;
	background_rect_alpha = 0.5;
	
	black_bar_x = 0;
	black_bar_y = 0;
	
	pause_bar_x = 0;
	pause_text_x = 0;
	pause_elements_x = 0;
	
	highlight_x = CAMERA_VIEW_W;
	
	transition_timer = 0;
	
	state = PAUSE_STATE.TRANSITION_IN;
	selection = 0;
	
	pause_alpha = 0;
	
	
	
	audio_pause_all();
	
	sound_play(sfx_menu_select);
	
	// Create the animator
	animator = new animator_create();
	
	// Add the selector animations
	animation_add(CHAR_SONIC, spr_hud_pause_mini_sonic, [60, 16], 1, true, true);
	animation_add(CHAR_TAILS, spr_hud_pause_mini_tails, [60, 16], 1, true, true);
	animation_add(CHAR_KNUX, spr_hud_pause_mini_knux, [60, 16], 1, true, true);
	
	// Play the correct animation
	var char = global.character;
	
	if(instance_exists(obj_player)) char = player_find(0).character;
	animation_play(animator, char);
	
	global.process_objects = false;
	
	enum PAUSE_STATE
	{
		TRANSITION_IN,	
		UPDATE,
		CONFIRM,
		TRANSITION_UPDATE,
	}
	
	enum PAUSE_TRANS
	{
		RESUME,
		RESTART,
		EXIT
	}