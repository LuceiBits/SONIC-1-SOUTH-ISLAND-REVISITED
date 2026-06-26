	/// @description 
	display_set_gui_size(WINDOW_WIDTH * 2, WINDOW_HEIGHT * 2);
	
	
	draw_set_font(global.font_debug);
	
	
	if(show_player)
	{
		var hd_w, hd_h;
		hd_w = WINDOW_WIDTH * 2;
		hd_h = WINDOW_HEIGHT * 2;
		
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		
		var t = (obj_global.time_end - obj_global.time_start) / 1000.0
		
		draw_text(0, 0, "Total Step Time: " + string_format(t, 2, 4))
		draw_text(0, 8, "Object Culling Pool: " + string(ds_list_size(obj_level.instance_list)))
	}
	