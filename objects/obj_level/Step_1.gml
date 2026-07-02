	/// @description Pause the game
	if(input_press(INPUT.START) && !obj_player.input_disable && !instance_exists(obj_pause) && !instance_exists(obj_game_over))
	{
		global.process_objects = false;
		instance_create_depth(0, 0, -100, obj_pause);
	}
	
	// Always increnment this
	platform_oscillate_timer++;