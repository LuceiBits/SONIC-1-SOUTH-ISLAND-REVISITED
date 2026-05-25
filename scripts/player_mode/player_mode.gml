function player_mode(){
	// Taken from mania, that's why its hex angle.
    var last_mode = mode;
	var s = max(16 - floor(abs(ground_speed * 2)), 0);
	
	floor_delay = max(floor_delay - 1, 0);
	
	mode = round(ground_angle / 90) % 4;
	
	//Change direction
	x_dir = dsin(90 * mode);
	y_dir = dcos(90 * mode);
}
