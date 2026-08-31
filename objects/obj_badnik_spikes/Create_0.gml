// Grounded badnik by joshyflip
	
// Inherit the parent event's code for the badnik
event_inherited();
	
// This is an example of a simple grounded badnik akin to a Motobug from Sonic 1.

// Set up badnik's values
waittimer = 0
badnikdirection = sign(image_xscale)
grounded = true;
y_speed = 0;
animator = new animator_create();

invframes = 0
parryTimer = 0

on_reset = function()
{
	x = xstart;	
	y = ystart;	
	waittimer = 0;
}
	
instance_register_culling([-32, -32, 32, 32], on_reset, CULL_FLAG.CHECK_ENTITY_START | CULL_FLAG.CHECK_ENTITY_POS);
	
animation_add(0, sprite_index, 0.1);
animation_add(1, sprite_index, 0);
animation_play(animator, 0);