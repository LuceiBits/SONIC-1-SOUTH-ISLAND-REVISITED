	// Grounded badnik by joshyflip

	// This is an example of a simple grounded badnik akin to a Motobug from Sonic 1.

	// Set up badnik's values
	waittimer = 0
	badnikdirection = 1
	grounded = true;
	y_speed = 0;
	animator = new animator_create();
	
	on_reset = function()
	{
		x = xstart;	
		y = ystart;	
		waittimer = 0;
	}
	
	animation_add(0, sprite_index, 0.3);
	instance_register_culling([-32, -32, 32, 32], on_reset, CULL_FLAG.CHECK_ENTITY_START | CULL_FLAG.CHECK_ENTITY_POS);
	
	animation_play(animator, 0);