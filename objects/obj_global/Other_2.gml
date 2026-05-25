/// @description Set the value
	//Variables for this object only
	process_object_list = ds_list_create();
	

	
	#macro DEVMODE false
	#macro Dev:DEVMODE true
	
	//TO ENABLE DEVELOPER FEATURES, PLEASE GO INTO THE TARGET ICON AND SELECT "Dev"
	//This helps you easily switch dev features on or off when compiling or testing your game
	
	
	// Initilize the game globals
	game_init_global_variables();
	game_init_font();
	game_init_collision();	
	game_init_music_list();
	
	
	// Bullshit to clean up
	#macro SOUND_EXTRA_LIFE if (global.extra_life_jingle){ play_sound(j_extra_life)} else {play_sound(sfx_extralife)}
	
	enum BONUSSTAGE 
	{
		OUTSIDE,
		GOING_TO,
		INSIDE,
		LEAVING,
	}
	
	bonus_stage_trigger = false
	
	//Create controllers:
	instance_create_depth(0, 0, 0, obj_window);
	instance_create_depth(0, 0, 0, obj_input);
	instance_create_depth(0, 0, 0, obj_music);
	instance_create_depth(0, 0, -100, obj_fade);
	
	//Controlers for dev mode
	if(global.dev_mode) 
	{
		instance_create_depth(0, 0, 0, obj_dev);
		instance_create_depth(0, 0, 0, obj_shell);
	}
	
	//Macros:
	#macro Input obj_input
	#macro WINDOW_WIDTH global.window_width
	#macro WINDOW_HEIGHT global.window_height
	#macro FRAME_TIMER global.object_timer
	
	global.red_ring_map = ds_map_create();
	
	
	//Ending event:
	room_goto_next();
	
