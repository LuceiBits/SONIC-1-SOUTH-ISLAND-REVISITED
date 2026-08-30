
//if !instance_on_screen(sprite_width,sprite_height)
//exit;

var diff = 0

if bbox_top < obj_water.y 
diff = point_distance(0,obj_water.y,0,bbox_top)

if diff > bbox_bottom 
exit;


if bubble_timer = 0
{
	with instance_create_depth(irandom_range(bbox_left,bbox_right),irandom_range(bbox_top + diff,bbox_bottom),1500,obj_bubble_current)
	{
	x_speed = lengthdir_x(other.spd, other.angle)
	y_speed = lengthdir_y(other.spd, other.angle)
	}
	bubble_timer = 1
}

if bubble_timer > 0 
bubble_timer -= 1