	// Grounded badnik by joshyflip
	
	// Inherit the parent event's code for the badnik
	event_inherited();
	
	// This is an example of a simple grounded badnik akin to a Motobug from Sonic 1.

	// Set up badnik's values
	madeVisible = false
	inRange = false
	fired = false
	waittimer = 0
	image_alpha = 0
	if obj_player.x > x
	badnikdirection = 1
	else
	badnikdirection = -1

	//grounded = true;
	y_speed = 0;
	animator = new animator_create();
	
	
	extraDelay = 0
	shootRange = 150
	on_reset = function()
	{
		x = xstart;	
		y = ystart;	
	madeVisible = false
	inRange = false
	fired = false
	waittimer = 0
	image_alpha = 0
	if obj_player.x > x
	badnikdirection = 1
	else
	badnikdirection = -1
	}
	inView = false
	
	instance_register_culling([-32, -32, 32, 32], on_reset, CULL_FLAG.CHECK_ENTITY_START | CULL_FLAG.CHECK_ENTITY_POS);
	
	animation_add(0, sprite_index, 0.3);
	animation_play(animator, 0);