	on_restart = function()
	{
		x = xstart;	
		
		show_debug_message("a")
	}
	
	instance_register_culling(noone, on_restart, true);