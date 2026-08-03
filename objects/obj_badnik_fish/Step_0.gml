// Inherit the parent event's code for the badnik
event_inherited();
	
depth = 0

y += y_speed
y_speed += 0.09375

if y >= ystart// && waittimer = 0 
{
	y = ystart
	y_speed = -5
}
	
if waittimer > 0
	waittimer -= 1

// Animate the badnik
animator_update(animator);
	
// Scale badnik in accordance to its direction
image_xscale = badnikdirection
