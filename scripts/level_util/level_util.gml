function level_reset_data()
{
	global.checkpoint_id = noone;
	global.time_store = 0;
	global.rings = 0;
	global.stage_timer = 0;
	ds_list_clear(global.checkpoint);
	ds_list_clear(global.store_object_state);
	ds_list_clear(global.special_ring_store);
	global.store_player_state.rings = 0;
	global.store_player_state.combinering = 0;
	//you may optionally want to clear the shield in store_player_state
	//do note this only runs when a stage is fully reset or loaded for this first time
}

function level_get_end_results()
{
	//Ring bonus
	ring_bonus = global.rings * 100;
	
	//Ring bonus
	var sec, minute;
	
	sec = floor(global.stage_timer/1000) mod 60;
	minute = floor(global.stage_timer/60000);
	time_bonus = 0;
	
	//Time result
	if(minute = 0 && sec <= 59) time_bonus = 50000;
	if(minute = 1 && sec <= 29) time_bonus = 10000;
	if(minute = 1 && sec >= 30 && sec <= 59) time_bonus = 5000;
	if(minute = 2 && sec <= 29) time_bonus = 4000;
	if(minute = 2 && sec >= 30 && sec <= 59) time_bonus = 3000;
	if(minute = 3 && sec <= 29) time_bonus = 1000;
	if(minute >= 3 && minute <= 9 && sec >= 30 && sec <= 59) time_bonus = 100;
	
	
}

function level_store_bg_visibility()
{
	for (var i = 0; i < instance_number(par_background); ++i)
	{
	    var bg = instance_find(par_background, i);
	    var name = object_get_name(bg.object_index);
		
	    global.store_background_visibility[$ name] = bg.visible;
	}
}

function level_reset_bg_visibility()
{
	global.store_background_visibility = {};
}
