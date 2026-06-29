// Bounce badnik by joshyflip
	event_inherited()
	// This is an example of a simple bounce badnik.

	// Set up badnik's values
	x_speed = 1;
	y_speed = 0;
	badnikframe = 0;
	
	on_reset = function()
	{
		x = xstart;
		y = ystart;
		
		show_debug_message(x)
	}
	
	instance_register_culling([-32, -32, 32, 32], on_reset);