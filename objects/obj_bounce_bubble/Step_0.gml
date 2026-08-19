if (instance_place(x,y,obj_player) && bounce_delay = 0 && visible = true) || (instance_place(x,y,obj_insta_shield) && visible = true)
{
	sound_play(sfx_bubble_jump);	
	if obj_player.on_terrain = false && !instance_exists(obj_insta_shield)
	{
		var _dir = point_direction(x,y,obj_player.x,obj_player.y)
		direction = _dir

		var magnitude = 0
		var yspd = (obj_player.y_speed)
		var xspd = (obj_player.x_speed)

		magnitude = point_distance(obj_player.x, obj_player.y, obj_player.x + xspd, obj_player.y + yspd)
		
		if magnitude < 4
		magnitude = 4

		magnitude *= 1.5

		var x_bounce = lengthdir_x(magnitude,_dir)
		var y_bounce = lengthdir_y(magnitude,_dir)
		obj_player.x_speed += x_bounce //* sign(direction)
		obj_player.y_speed += y_bounce //* sign(direction)
	}
	else instance_exists(obj_insta_shield)
	{
		sound_play(sfx_water_splash);	
	}

	bounce_delay = 100

	// duped bubble code
	with(obj_player)
	{
		air = 0;
		//x_speed = 0;
		//y_speed = 0;
		//ground_speed = 0;
		state = player_state_normal;
		animation_play(animator, ANIM.BREATHE);
		sound_play(sfx_breathe);
	}
}

if bounce_delay > 0 || bbox_top < obj_water.y
{
	visible = false
	bounce_delay -= 1
}
else if bbox_top > obj_water.y && !instance_place(x,y,obj_player)
	visible = true