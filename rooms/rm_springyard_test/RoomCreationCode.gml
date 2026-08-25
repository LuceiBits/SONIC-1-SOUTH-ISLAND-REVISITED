	//NOTE: Duplicate this room to make levels!
	with(obj_level)
	{
		//Set stage music and loop points
		stage_music = MUSIC.SPRING_YARD_ZONE_ACT_1
		
		//Set level name
		stage_name = "SPRING YARD ZONE";
		
		//Set stage act
		act = 1;
		
		//Is next level doing act transition in case if you do a multi-zone level.
		act_transition = false;
		
		//Animal array
		animal = [A_FLICKY, A_CUCKY, A_RICKY];
		
		//Next level
		next_level = rm_waterfall_zone
		
		show_collisions = true
	}