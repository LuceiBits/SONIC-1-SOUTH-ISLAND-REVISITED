	// Remove the object from the platform attach list
	with (par_moving_platform)
	{
		var i = ds_list_find_index(attached_list, other.id);
		if (i != -1)
			ds_list_delete(attached_list, i);
	}