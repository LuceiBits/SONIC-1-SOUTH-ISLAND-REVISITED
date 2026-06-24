/// @description Culling
	//Screen values
	var c, cx, cy, sw, sh;
	c = view_camera[view_current]
	cx = camera_get_view_x(c)
	cy = camera_get_view_y(c)
	sw = global.window_width;
	sh = global.window_height;
	
	var inside;
	var a;
	var count = ds_list_size(instance_list);
	
	var cullL = cx - CULL_REGION_W;
	var cullR = cx + sw + CULL_REGION_W;
	var cullT = cy - CULL_REGION_H;
	var cullB = cy + sh + CULL_REGION_H;
	
	for (var i = 0; i < count; ++i)
	{
		// Get the object from the list
		a = instance_list[| i];
		
		// If instance doesn't exist, wipe it from the culling list
		if(!is_struct(a) || !instance_exists(a.inst_id) && !a.cull_flag)
		{
			ds_list_delete(instance_list, i);
			continue;
		}
			
		// Check if the object is inside the culling area
		inside = cullR > a.inst_id.x - a.region[0] && cullL < a.inst_id.x + a.region[0] &&
		cullB > a.inst_id.y - a.region[1] && cullT < a.inst_id.y + a.region[1];
		
		// Entering the culling region
		if(!inside && !a.cull_flag)
		{
			a.cull_flag = true;
			instance_deactivate_object(a.inst_id);
		}
		
		// Exiting the culling region
		if(inside && a.cull_flag)
		{
			a.cull_flag = false;
			instance_activate_object(a.inst_id);	
		}
	}