	/// @description Post - Game events
	
	// Run the music engine
	music_update();
	
	//Enable all of the objects so the draw event can be processed
	for (var i = 0; i < ds_list_size(process_object_list); i++)
	{
		instance_activate_object(process_object_list[| i]);
	}
	
	//Clear the list
	ds_list_clear(process_object_list);
	
	// Get the timer at the end of processing
	time_end = get_timer();