live_auto_call


if obj_player.state = player_state_knockout || obj_player.state = player_state_pole_current || obj_player.state = player_state_death || !obj_player.underwater || obj_player.state = player_state_drown 
exit;

if place_meeting(x, y, obj_player) //player_collide_object()
{
	var _angle = image_angle
	if image_index = 1
		_angle -= 45 * sign(image_yscale)
	
	with obj_player
	{
		state = player_state_watercurrent
		
		var _movx = hold_right - hold_left
		var _movy = hold_down - hold_up
		
		var _movespeed = 2
		
		x_speed = lengthdir_x(other.spd, _angle) + (_movespeed * _movx)
		y_speed = lengthdir_y(other.spd, _angle) + (_movespeed * _movy)
		
		state = player_state_watercurrent
	}
}

