function player_mode(){
	//Mode macros
	#macro CMODE_FLOOR 0
	#macro CMODE_LWALL 1
	#macro CMODE_RWALL 3
	#macro CMODE_CEILING 2
	
	// Taken from mania, that's why its hex angle.
    var last_mode = mode;
	var s = max(16 - floor(abs(ground_speed * 2)), 0);
	
	floor_delay = max(floor_delay - 1, 0);
	
	mode = round(ground_angle / 90) % 4;
	
	//Change direction
	x_dir = dsin(90 * mode);
	y_dir = dcos(90 * mode);
}
