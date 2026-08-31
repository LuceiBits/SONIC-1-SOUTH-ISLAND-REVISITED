
function player_state_corkscrew()
{
	var _spd = 0;
	_spd = ground_speed/3;
	var _corkPos = 0;
	image_yscale = 1
	var _corksew = instance_place(x,y,obj_corkscrew)
	image_yscale = 1
	image_speed = 0
	
	movement_allow = false;
	direction_allow = false; 
	
	if (_corksew != noone)
	{
		ground_angle = 0
		var _spr_x = _corksew.sprite_height //768/2; 
		var _off_y = 90;
		var _off_x = -14;
		var _h = 35;
		var _w = 178;

		_corkPos = (obj_player.x - _corksew.x) / _spr_x;
		
		obj_player.x += _spd;
		yold = obj_player.y
		obj_player.y = _corksew.y + _off_y - _h + _h * dcos(((obj_player.x - _corksew.x) / _w) * 180 + _off_x);
		y_speed = 0
		if !animation_is_playing(animator, ANIM.ROLL)
		{
			if image_xscale = 1
			{
				animation_play(animator, ANIM.CORKSCREW);
				animator.animation_frame = floor(_corkPos * 12)
			}
			else
			{
				animation_play(animator, ANIM.CORKSCREW_FRONT);
				animator.animation_frame = floor((-_corkPos * 12) + 12) 
			}
			animator.animation_speed = 0
		}
	}
	else
	{
		obj_player.state = player_state_normal;
	}
}