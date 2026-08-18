// Grounded badnik by joshyflip
	
// Inherit the parent event's code for the badnik
event_inherited();
	
// This is an example of a simple grounded badnik akin to a Motobug from Sonic 1.

// Set up badnik's values
waittimer = 0
badnikdirection = 1
grounded = true;
x_speed = 0;
y_speed = 0;
animator = new animator_create();
	
on_reset = function()
{
	x = xstart;	
	y = ystart;	
	waittimer = 0;
	
	if y > obj_water.bbox_top
	underwater = true
	else
	underwater = false
	
	
	if underwater = false
	{
	var fcheck = collision_get_distance(x, y + 15, COLLISION_MODE.FLOOR, PLANE.A, true);
	y += fcheck
	}
	
}
	
instance_register_culling([-32, -32, 32, 32], on_reset, CULL_FLAG.CHECK_ENTITY_START | CULL_FLAG.CHECK_ENTITY_POS);
	
animation_add(0, sprite_index, 15);
animation_play(animator, 0);

underwater = true