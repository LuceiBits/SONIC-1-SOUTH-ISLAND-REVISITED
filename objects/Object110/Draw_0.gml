/*	draw_state_save();
	for (var i = 0; i < ds_list_size(instance_list); ++i) 
	{
		var a = instance_list[| i];
		
		
		
		draw_set_colour(c_red);
		draw_set_alpha(0.5);
		
		draw_rectangle(a.inst_id.x + a.region.left, a.inst_id.y + a.region.top, a.inst_id.x + a.region.right, a.inst_id.y + a.region.bottom, false);
		
		
	}
	
	draw_state_restore();