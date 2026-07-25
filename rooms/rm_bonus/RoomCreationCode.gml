
	//Don't forget to get rid of this code when you will be making your own bonus stage!
	obj_camera.target_left = obj_gumball_machine.x - WINDOW_WIDTH/2;
	obj_camera.target_right = obj_gumball_machine.x + WINDOW_WIDTH/2;
	
	with(obj_level)
	{
		//Set stage music
		stage_music = MUSIC.BONUS;
		
		//Set level state
		level_state = LEVEL_STATE.BONUS;
	}