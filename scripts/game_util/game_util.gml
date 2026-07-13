function game_os_get_string()
{
	switch(os_type)
	{
		case os_windows: return "Windows"; 
		case os_gxgames: return "GX Games"; 
		case os_operagx: return "Opera GX"; 
		case os_linux: return "Linux"; 
		case os_macosx: return "MacOS"; 
		case os_ios: return "iOS"; 
		case os_tvos: return "tvOS"; 
		case os_android: return "Android"; 
		case os_ps4: return "PlayStation 4"; 
		case os_ps5: return "PlayStation 5"; 
		case os_gdk: return "GDK"; 
		case os_xboxseriesxs: return "XBOX"; 
		case os_switch: return "Switch"; 
		case os_switch2: return "Switch 2"; 
		case os_unknown: return "Unknown"; 
		default: return "Unknown"
	}
}

function game_call_window_resize()
{
	//Fullscreen
	window_set_fullscreen(global.window_size >= global.window_size_limit);
	
	//Screen resizing
	camera_set_view_size(view_camera[view_current], global.window_width, global.window_height);

	//Resize the window:
	window_set_size(global.window_width*global.window_size, global.window_height*global.window_size);

	//Resize the surface:
	surface_resize(application_surface, global.window_width, global.window_height);
	
	//Window size limiter
	global.window_size_limit = round(display_get_width() / global.window_width);
	
	//Center the screen
	window_center();		
}

function game_has_all_emeralds()
{
	for (var i = 0; i < array_length(global.emeralds); ++i)
	{
	    if (!global.emeralds[i])
		{
			return false;
		}
	}

	return true;
}

function game_emerald_count()
{
	var n = 0;
	for (var i = 0; i < array_length(global.emeralds); ++i)
		if (global.emeralds[i]) n++;
	return n;
}