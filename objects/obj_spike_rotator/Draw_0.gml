live_auto_call

angle = obj_level.platform_oscillate_timer
sin_angle = sin256(angle)/256;
cos_angle = cos256(angle)/256;
var _length = abs(round(image_yscale))

var _lengthPos = 0
var _x = 0
var _yOffset = 0
var _y = 0

for (var i = 0; i < _length; i++)
{
	_lengthPos = i * 16
	_x = x + lengthdir_x(_lengthPos, angle)
	_yOffset = (bbox_bottom - y)
	_y = y + lengthdir_y(_lengthPos, angle) + _yOffset
	
	draw_sprite(sprite_index, 0, _x, _y)
	
	player_spike_parry(_x,_y)
}

//draw_line(x, bbox_bottom, _x, _y)

// weird placeholder thing but it works
if(obj_player.state == player_state_death || obj_player.state == player_state_drown || obj_player.disable_death)
	exit

if collision_line(x, bbox_bottom, _x, _y, obj_player, false, true)
	player_hurt()