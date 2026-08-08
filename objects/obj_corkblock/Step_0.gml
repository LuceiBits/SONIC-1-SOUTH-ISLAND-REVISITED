live_auto_call

var player = player_find(0);
var col = player_act_semi_solid();

var _ymiddle = y + sprite_get_height(sprite_index) / 2


if instance_exists(obj_water)
{
	if _ymiddle > obj_water.y
		y_speed = math_approach(y_speed, -1, 0.1)
	else
		y_speed += 0.21875
}



if(!ground)
{
	//Update position by speed
	y += y_speed;
		
	//Gravity
	if(!ground) 
	{
		y_speed += 0.2;
	}
		
	//Collision
	var c = collision_active_sensor(floor((bbox_right - bbox_left) / 2), floor(bbox_bottom - y - 1), COLLISION_MODE.FLOOR, PLANE.A, true);
		
	if(c.height < 0 && y_speed >= 0)
	{
		y_speed = 0;
		ground = true;
		y += c.height;
	}
}





if mouse_check_button(mb_left)
{
	x = mouse_x
	y = mouse_y
}

