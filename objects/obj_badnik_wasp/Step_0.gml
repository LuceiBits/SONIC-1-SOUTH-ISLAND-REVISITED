// Inherit the parent event's code for the badnik
event_inherited();
	
depth = 0

// Move the badnik when the wait timer is at 0
if (waittimer == 0)
{
	animation_play(animator, 0, true);
		
	if badnikdirectionPrior != badnikdirection
		badnikdirection = badnikdirectionPrior
		
	x += (badnikdirection * 4);
}
	
image_xscale = badnikdirection
	
if (point_distance(x, 0, obj_player.x, 0) <= shootRange && waittimer = 0 && extraDelay = 0) && (y > (obj_player.y - 120) && y < (obj_player.y + 120))
{
	animation_play(animator, 1, true);
		
	var timeToFire = 60
	waittimer = /*70 + */timeToFire
	extraDelay = 200
	alarm[0] = timeToFire/2
}
	
if waittimer > 0
	waittimer -= 1
	
if extraDelay > 0 && waittimer = 0
	extraDelay -= 1
	
// Animate the badnik
animator_update(animator);
	
// Scale badnik in accordance to its direction
image_xscale = badnikdirection