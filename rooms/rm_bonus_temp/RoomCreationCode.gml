	with(obj_level)
	{
		with obj_dev // this stupid with statement needs to exist of else temp_bonus is fucking invisible
		show_collision = true
		//Set stage music and loop points
		stage_music = MUSIC.TEMP
		
		//Set level name
		stage_name = "Test Level";
		
		level_state = LEVEL_STATE.BONUS
		//Set stage act
		act = 0;
		
		//Is next level doing act transition in case if you do a multi-zone level.
		act_transition = false;
		
		//Animal array
		animal = [A_FLICKY, A_CUCKY, A_RICKY];
		
		//Next level
		if global.previous_room = rm_springyard_1
		{
		next_level = rm_waterfall_zone;
		}
		if global.previous_room = rm_waterfall_zone
		{
		next_level = rm_labyrinth_1;
		}
		if global.previous_room = rm_labyrinth_1
		{
		next_level = rm_playtest_end;
		}
		
	}