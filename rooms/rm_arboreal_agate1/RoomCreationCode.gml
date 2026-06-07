	with(obj_zone)
	{
		//Set stage music and loop points
		stage_music = MUSIC.ARBOREAL_AGATE1;
		
		//Set level name
		stage_name = "Arboreal Agate";
		
		//Set stage act
		act = 1;
		
		//Is next level doing act transition
		act_transition = true;
		
		//Animal array
		animal = [A_FLICKY, A_CUCKY, A_RICKY];
		
		//Next level
		next_level = rm_arboreal_agate2;
	}