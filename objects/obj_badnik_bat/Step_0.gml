// Inherit the parent event's code for the badnik
event_inherited();
	
depth = 0

if flying = 1
{
if y_speed = 0
y_speed = 1
y += y_speed
y_speed += 0.09375
if y > obj_player.y
flying = 2
}

if flying = 0
{
animation_play(animator, 0, true);
y_speed = 0
if point_distance(x,y,obj_player.x,obj_player.y) < 180
flying = 1
}

if flying = 2
{
y_speed = 0	
			if obj_player.x > x 
		{
		image_xscale = 1
		show_debug_message("FACE PLAYER ON RIGHT")
		}

		if obj_player.x < x 
		{
		image_xscale = -1
		show_debug_message("FACE PLAYER ON LEFT")
		}
flying = 4
}

if flying = 4
{
animation_play(animator, 1, true);
x_speed = 2 * (image_xscale);	
x += x_speed
}
//if y >= ystart// && waittimer = 0 
//{
//	y = ystart
//	y_speed = -5
//}
	

// Animate the badnik
animator_update(animator);
	
// Scale badnik in accordance to its direction
//image_xscale = badnikdirection
