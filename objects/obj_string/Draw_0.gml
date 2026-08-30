live_auto_call

var _p = obj_player

var _left = bbox_left + 5
var _right = bbox_right - 5
var _pX = clamp(string_x, _left, _right)

var _lines = [
	#b44824,
	#fcb490,
	#d89048,
	#6c0000
]

for (var i = 0; i < array_length(_lines); i++)
{
	var _offsetY = i
	
	draw_set_colour(_lines[i])
	draw_line(_left, bbox_top + _offsetY, _pX, string_y_bottom + _offsetY)
	draw_line(_pX, string_y_bottom + _offsetY, _right, bbox_top + _offsetY)
}
draw_set_colour(c_white)

draw_sprite_ext(spr_string_holder, 0, x, y, 1, 1, 0, c_white, 1)
draw_sprite_ext(spr_string_holder, 0, bbox_right, y, -1, 1, 0, c_white, 1)

/*
var _datalist = 
[
	["TIMER", timer],
	["COOLDOWN", cooldown],
	["TOUCHING", touchin]
]
for (var i = 0; i < array_length(_datalist); i++)
{
	var _tag = _datalist[i][0]
	var _data = string(_datalist[i][1])
	var _text = _tag + ": " + _data
	
	draw_text(x, y - (10 * (i+1)), _text)
}
*/