live_auto_call

if swing_pole_cooldown > 0 && !player_collide_object()//!instance_place(x,y,obj_player)
	swing_pole_cooldown -= 1

if swing_pole_cooldown > 0
	exit;



if obj_player.state != player_state_watercurrent && obj_player.state != player_state_death
{
	
	if /*instance_place(x,y,obj_player)*/player_collide_object() && 
		abs(obj_player.x_speed) > 0 && 
		obj_player.on_terrain = false &&
		swing_pole_cooldown = 0 &&
		obj_player.state != player_state_poleswing &&
		obj_player.state != player_state_knockout
	{
		with obj_player
		{
			x = other.x
			pole_id = other.id
			pole_xspd_save = x_speed
			//y_speed = (abs(x_speed)*0.9) * sign(y_speed)
			//if y_speed < 0
			y_speed = -abs(x_speed)
			x_speed = 0
			state = player_state_poleswing
			animation_play(animator, ANIM.POLESWING);
		}
	}
}
else
{
		if player_collide_object() && swing_pole_cooldown = 0 && obj_player.state != player_state_death
	{
		with obj_player
		{
			x = other.x
			pole_id = other.id
			//pole_xspd_save = x_speed
			//y_speed = (abs(x_speed)*0.9) * sign(y_speed)
		//	if y_speed < 0
				//y_speed = min(-abs(x_speed), y_speed)
			//x_speed = 0
			state = player_state_pole_current
			animation_play(animator, ANIM.POLESWING);
		}
	}
}
