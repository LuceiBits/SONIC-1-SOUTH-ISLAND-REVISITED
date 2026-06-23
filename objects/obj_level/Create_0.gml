/// @description Setup
	instance_list = ds_list_create();
	
	disable_timer = false;
	badnik_chain = 0;
	emerald_array = [];
	
	//====================================================//
	//				 **DEFAULT STAGE SETUP**			  //
	//====================================================//
	
	//Set stage music and loop points
	stage_music = MUSIC.TECHDEMO_TOWER;
		
	//Set level name
	stage_name = "Empty Level";
		
	//Set stage act
	act = 1;
		
	//Is next level doing act transition
	act_transition = false;
		
	//Animal array
	animal = [A_FLICKY, A_CUCKY, A_RICKY];
		
	//Next level
	next_level = room;