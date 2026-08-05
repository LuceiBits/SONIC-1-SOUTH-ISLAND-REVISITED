


if swing_pole_cooldown > 0 && !instance_place(x,y,obj_player)
{
swing_pole_cooldown -= 1
}

if swing_pole_cooldown > 0
exit;

if instance_place(x,y,obj_player) && abs(obj_player.x_speed) > 0 && obj_player.on_terrain = false 
{
	with obj_player
	{
		if state != player_state_poleswing && other.swing_pole_cooldown = 0
		{
		x = other.x
		pole_id = other.id
		pole_xspd_save = x_speed
		y_speed = (abs(x_speed)*0.9) * -1
		state = player_state_poleswing
		}
	}
}
