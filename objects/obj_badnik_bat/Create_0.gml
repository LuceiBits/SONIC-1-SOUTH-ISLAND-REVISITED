	// Grounded badnik by joshyflip
	
	// Inherit the parent event's code for the badnik
	event_inherited();
	
	// This is an example of a simple grounded badnik akin to a Motobug from Sonic 1.

	// Set up badnik's values
	waittimer = 0
	flying = 0
	//grounded = true;
	y_speed = 0;
	animator = new animator_create();
	
		
		//animation_add(0, spr_newton, 1,, true);
	animation_add(0, spr_bat_perched, 0,, true);
	animation_add(1, spr_bat_fly, 0.2,, true);
	animation_play(animator, 0, true);

	on_reset = function()
	{
		flying = 0
		x_speed = 0;
		y_speed = 0;
		x = xstart;	
		y = ystart;	
		//waittimer = 0;
	}

	instance_register_culling([-32, -32, 32, 32], on_reset, CULL_FLAG.CHECK_ENTITY_START | CULL_FLAG.CHECK_ENTITY_POS);
	
	animation_add(0, sprite_index, 0.3);
	animation_play(animator, 0);