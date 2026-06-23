	draw_set_font(global.font_debug);
	draw_text(0, 0, "Instances in culling pool amount: " + string(ds_list_size(obj_global.instance_list)));
	//draw_text(0, 8, "Amount of Sonic objects: " + string(instance_number(Object111)));
	
	/*
	for (var i = 0; i < ds_list_size(instance_list); ++i) 
	{
		draw_text(0, 8 * i, string(instance_list[| i]));
	}