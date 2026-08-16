// Bounce badnik by joshyflip
	event_inherited()
	// This is an example of a simple bounce badnik.

	// Set up badnik's values
	x_speed = 0;
	y_speed = 0;
	badnikframe = 0;
	grounded = true
	drill_jumped = false
	check_buffer = 0
	
	animator = new animator_create();
	
	animation_add(0, spr_drillmole_wait, 0,, true);
	animation_add(1, spr_drillmole_jump, 0,, true);
	animation_add(2, spr_drillmole_walk, 0,, true);
	animation_play(animator, 0, true);
	
	on_reset = function()
	{
		animation_play(animator, 0, true);
		x_speed = 0;
		y_speed = 0;
		grounded = true
		drill_jumped = false
		check_buffer = 0
		x = xstart;
		y = ystart;
	}
	
		instance_register_culling([-32, -32, 32, 32], on_reset, CULL_FLAG.CHECK_ENTITY_START | CULL_FLAG.CHECK_ENTITY_POS);