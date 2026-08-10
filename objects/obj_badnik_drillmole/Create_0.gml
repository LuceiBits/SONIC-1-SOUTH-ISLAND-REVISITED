// Bounce badnik by joshyflip
	event_inherited()
	// This is an example of a simple bounce badnik.

	// Set up badnik's values
	x_speed = 1;
	y_speed = 0;
	badnikframe = 0;
	
	animator = new animator_create();
	
	animation_add(0, spr_ribbot, 0.2,, false);
	animation_play(animator, 0, true);
	
	on_reset = function()
	{
		x = xstart;
		y = ystart;
	}
	
	instance_register_culling([-32, -32, 32, 32], on_reset);