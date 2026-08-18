/// @description Script
	if water_kill = true && instance_exists(obj_water)
		{
		if y > obj_water.y
		instance_destroy()
		}
	//Update speeds
	x += x_speed;
	y += y_speed;
	
	//Gravity
	y_speed += grav;
	
	//Hurt the player
	if(player_collide_object(COLLISION.MAIN))
	{
		var fly_angle = 90 - point_direction(obj_player.x, obj_player.y,x,y) 
		var fly_cond = (obj_player.state == player_state_tailsfly && abs(fly_angle) < 45)
		if(obj_player.shield == SHIELD.NONE && !fly_cond)
		{
			player_hurt();
		}
		else
		{
			if(!bounce)
			{
				var angle = point_direction(x, y, obj_player.x, obj_player.y);
				x_speed = 12 * -dcos(angle);
				y_speed = 12 * dsin(angle);
				grav = 0;
				bounce = true;
			}
		}
	}
	
	if solid_kill
		{
		var fcheck = collision_get_distance(x, y + 15, COLLISION_MODE.FLOOR, PLANE.A, true);
		var wallcheck = collision_get_distance(x + 12 * badnikdirection, y, badnikdirection ? COLLISION_MODE.LEFT_WALL : COLLISION_MODE.RIGHT_WALL, PLANE.A, true);	
	
		if fcheck <= 1 || wallcheck <= 1
		instance_destroy()
		}
	
	
	//Destroy off screen
	if(!instance_on_screen(64, 64)) 
	{
		instance_destroy();
	}