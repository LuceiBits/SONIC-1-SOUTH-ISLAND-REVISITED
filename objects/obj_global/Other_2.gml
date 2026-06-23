/// @description Set the value
	//Variables for this object only
	process_object_list = ds_list_create();
	instance_list = ds_list_create();
	time_start = 0;
	time_end = 0;
	
	#macro DEVMODE false
	#macro Dev:DEVMODE true
	
	//TO ENABLE DEVELOPER FEATURES, PLEASE GO INTO THE TARGET ICON AND SELECT "Dev"
	//This helps you easily switch dev features on or off when compiling or testing your game
	
	
	// Initilize the game globals
	game_init_global_variables();
	game_init_font();
	game_init_collision();	
	game_init_music_list();
	
	// Controllers init
	input_init();
	
	// Define input actions
	input_add_action(INPUT.UP, vk_up, gp_padu, [gp_axislv, true]);
	input_add_action(INPUT.DOWN, vk_down, gp_padd, [gp_axislv, false]);
	input_add_action(INPUT.LEFT, vk_left, gp_padl, [gp_axislh, true]);
	input_add_action(INPUT.RIGHT, vk_right, gp_padr, [gp_axislh, false]);
	input_add_action(INPUT.A, "A", gp_face1);
	input_add_action(INPUT.B, "S", gp_face2);
	input_add_action(INPUT.C, "D", gp_face3);
	input_add_action(INPUT.START, vk_enter, gp_start);
	
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
	instance_create_depth(0, 0, 0, obj_music);
	instance_create_depth(0, 0, -100, obj_fade);
	
	//Controlers for dev mode
	if(global.dev_mode) 
	{
		instance_create_depth(0, 0, 0, obj_dev);
		instance_create_depth(0, 0, 0, obj_shell);
	}
	
	//Macros:
	#macro WINDOW_WIDTH global.window_width
	#macro WINDOW_HEIGHT global.window_height
	#macro FRAME_TIMER global.object_timer
	
	//Ending event:
	room_goto_next();
	
