function player_mode()
{
	// Change the ground mode
	mode = round(ground_angle / 90) % 4;

	//Change direction
	x_dir = dsin(90 * mode);
	y_dir = dcos(90 * mode);
}
