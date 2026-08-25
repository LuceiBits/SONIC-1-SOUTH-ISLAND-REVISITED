live_auto_call

var _p = obj_player

if player_collide_object(, COLLISION.TOP) && cooldown = 0 && !touchin && !active
{
	snd_use = sound_play(sfx_string_use, , 2)
	audio_sound_pitch(snd_use, 0.4 + abs(_p.y_speed/15))
	active = true
	touchin = true
}

if active
{
	timer++
	
	string_x = _p.x
	string_y_bottom = _p.bbox_bottom - 8
	_p.y_speed = lerp(_p.y_speed, 0, 0.1)
	
	if timer > 10
	{
		_p.y_speed *= -3
		_p.jump_flag = false//true
		//_p.insta_shield_used = false
		
		audio_stop_sound(snd_use)
		var _sfx = sound_play(sfx_spring)//sfx_rubber)
		audio_sound_pitch(_sfx, 0.4 + abs(_p.y_speed/15))
		
		//cooldown = 20
		timer = 0
		active = false
	}
}
else
{
	string_y_bottom_spd = lerp(string_y_bottom_spd, (y - string_y_bottom) * 0.5, 0.2)
	string_y_bottom += string_y_bottom_spd
}

var _pBottom = _p.hitbox_h + _p.y
if _pBottom < bbox_top //!player_collide_object(, COLLISION.TOP)
	touchin = false

cooldown = max(cooldown - 1,0)

/*
if keyboard_check_pressed(ord("R"))
	active = false
*/
