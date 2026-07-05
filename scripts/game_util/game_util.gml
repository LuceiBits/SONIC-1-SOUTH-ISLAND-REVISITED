function game_os_get_string()
{
	switch(os_type)
	{
		case os_windows: return "Windows"		break; 
		case os_gxgames: return "GX Games"		break; 
		case os_linux: return "Linux"		break; 
		case os_macosx: return "MacOS"		break; 
		case os_ios: return "IOS"		break; 
		case os_tvos: return "tvOS"		break; 
		case os_android: return "Android"		break; 
		case os_ps4: return "PlayStaion 4"		break; 
		case os_ps5: return "PlayStaion 5"		break; 
		case os_gdk: return "GDK"		break; 
		case os_xboxseriesxs: return "Xbox"		break; 
		case os_switch: return "Switch"		break; 
		case os_unknown: return "Unknown"		break; 
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