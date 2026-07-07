	/// @description Insert description here
	// You can write your code in this editor
	delay = 0
	timer = 0

	options_array = ["CONTINUE", "RESTART", "EXIT"];

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
	
	global.process_objects = false;
	
	audio_pause_all();
	

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