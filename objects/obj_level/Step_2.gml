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
		inside = cullR > a.inst_id.x + a.region.left && cullL < a.inst_id.x + a.region.right &&
		cullB > a.inst_id.y + a.region.top && cullT < a.inst_id.y + a.region.bottom;
		
		// Check if the object's starting position is in the culling area
		if (!inside)
		{
		    inside = a.use_start_pos || (cullR > a.inst_id.xstart + a.region.left && cullL < a.inst_id.xstart + a.region.right &&
			cullB > a.inst_id.ystart + a.region.top && cullT < a.inst_id.ystart + a.region.bottom);
		}
		
		// Do not cull if the object is ignored for culling
		if(a.type = CULL_TYPE.DISABLE)
			continue;
		
		// Entering the culling region
		if(!inside && !a.cull_flag)
		{
			if(a.culled)
				a.culled();
			
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