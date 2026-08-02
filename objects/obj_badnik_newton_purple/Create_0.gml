	// Grounded badnik by joshyflip
	
	// Inherit the parent event's code for the badnik
	event_inherited();
	
	// This is an example of a simple grounded badnik akin to a Motobug from Sonic 1.

	// Set up badnik's values
	waittimer = 0
	
	madeVisible = false
	inRange = false
	fired = false
	if obj_player.x > x
	badnikdirection = 1
	else
	badnikdirection = -1

	grounded = true;
	y_speed = 0;
	animator = new animator_create();
	
	animation_add(0, spr_newton, 1,, true);
	animation_add(1, spr_newton_1, 1,, true);
	animation_play(animator, 0, true);
	extraDelay = 0
	shootRange = 150
	on_reset = function()
	{
		x = xstart;	
		y = ystart;	
		waittimer = 0;
	}
	inView = false
	
	instance_register_culling([-32, -32, 32, 32], on_reset, CULL_FLAG.CHECK_ENTITY_START | CULL_FLAG.CHECK_ENTITY_POS);
	
	animation_add(0, sprite_index, 0.3);
	animation_play(animator, 0);