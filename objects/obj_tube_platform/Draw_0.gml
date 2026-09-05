live_auto_call

if !instance_exists(tube_id)
{
	draw_self()
	depth = -2
	exit
}

with tube_id
{
	if !instance_on_screen()
		exit
}

var _is_front = depth = tube_id.depth - 1

if _is_front
{
	// Make it semi solid and find the player object
	var col = player_act_semi_solid();
	var p = player_find(0);
}
	
// Get previous position values
var old_x = x;
var old_y = y;

angle = global.object_timer
angle += angle_add
angle += angle_position_offset

var _sides = [
	[0, 0], // Top
	[1, 16], // Side Bottom
	[3, 16], // Bottom
	[1, 0] // Side Top
	
]

var _tube_height = tube_id.sprite_height
var _tube_diff = bbox_top - tube_id.bbox_top
for (var i = 0; i < array_length(_sides); i++)
{
	var _angle = angle + (90*i)
	
	var _scale = dcos(_angle)
	_scale = max(_scale, 0)
	
	/*
	if _scale == 0
		break
	*/
	var _index = _sides[i][0]
	var _y_offset = _sides[i][1]
	
	var _y_fix = i == 2 || i == 3
	
	var _x = floor(xstart)
	var _y = floor(ystart) + _y_offset * dsin(_angle)
	
	if _y_fix
		_scale *= -1
	
	_y += dsin(angle) * ((_tube_height) + 16*2)/2
	
	_x = floor(_x)
	_y = floor(_y)
	
	// if is the front sprite
	if i == 0
	{
		x = _x
		y = _y
	}
	
	draw_sprite_ext(sprite_index, _index, floor(_x), floor(_y), 1, _scale, 0, image_blend, image_alpha);
}

var _angle_wrap = floor(angle mod 360)
if _angle_wrap >= 270 && _angle_wrap <= 360 || _angle_wrap >= 0 && _angle_wrap <= 90
	depth = tube_id.depth - 1
else
	depth = tube_id.depth + 1

if _is_front
{
	// Move the player
	if(col && p.ground)
	{
		p.x += x - old_x;
		p.y += y - old_y;
	}
}