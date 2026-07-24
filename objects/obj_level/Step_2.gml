/// @description Culling
	
	#region				// Level culling system
	var inside = false;
	var inst;
	var count = ds_list_size(instance_list);
	
	// Camera culling regions
	var cullL = CAMERA_VIEW_X - CULL_REGION_W;
	var cullR = CAMERA_VIEW_X + CAMERA_VIEW_W + CULL_REGION_W;
	var cullT = CAMERA_VIEW_Y - CULL_REGION_H;
	var cullB = CAMERA_VIEW_Y + CAMERA_VIEW_H + CULL_REGION_H;
	
	for (var i = 0; i < count; ++i)
	{
		// Get the object from the list
		inst = instance_list[| i];
		
		// If instance doesn't exist, wipe it from the culling list
		if(!is_struct(inst) || !instance_exists(inst.inst_id) && !inst.cull_flag)
		{
			ds_list_delete(instance_list, i);
			continue;
		}
			
		// Check if the object is inside the culling area
		if(inst.flag & CULL_FLAG.CHECK_ENTITY_POS)
		{
			inside = cullR > inst.inst_id.x + inst.region.left && cullL < inst.inst_id.x + inst.region.right &&
			cullB > inst.inst_id.y + inst.region.top && cullT < inst.inst_id.y + inst.region.bottom;
		}
		
		// Check if the object's starting position is in the culling area
		if (!inside && inst.flag & CULL_FLAG.CHECK_ENTITY_START)
		{
		    inside = (cullR > inst.inst_id.xstart + inst.region.left && cullL < inst.inst_id.xstart + inst.region.right &&
			cullB > inst.inst_id.ystart + inst.region.top && cullT < inst.inst_id.ystart + inst.region.bottom);
		}
		
		// Do not cull if the object is ignored for culling
		if(inst.type = CULL_TYPE.DISABLE)
			continue;
		
		// Entering the culling region
		if(!inside && !inst.cull_flag)
		{
			// Trigger the culling event
			if(is_method(inst.culled))
				inst.culled();
			
			inst.cull_flag = true;
			instance_deactivate_object(inst.inst_id);
		}
		
		// Exiting the culling region
		if(inside && inst.cull_flag)
		{
			inst.cull_flag = false;
			instance_activate_object(inst.inst_id);	
		}
	}
	
	#endregion
	