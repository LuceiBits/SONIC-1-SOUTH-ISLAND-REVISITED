// STOLEN FROM PIZZA TOWER !!!! GAAHHH!!!!
function in_camera(_threshold = 0/*, _camera = view_camera[0]*/)
{
	var camx = camera_get_view_x(view_camera[0])
	var camy = camera_get_view_y(view_camera[0])
	var camw = camera_get_view_width(view_camera[0])
	var camh = camera_get_view_height(view_camera[0])
	
	var _result = bbox_left < (camx + camw + _threshold) && bbox_right > (camx - _threshold) && bbox_top < (camy + camh + _threshold) && bbox_bottom > (camy - _threshold)
	
	return _result
}

function set_collision_colors()
{
	live_auto_call
	// Manually set the collision colors back
	//[RED, GREEN, BLUE, ALPHA]
	var _redTint = fx_create("_filter_tintfilter")
	fx_set_parameter(_redTint, "g_TintCol", [1, 0, 0, 1])
	fx_set_single_layer(_redTint, true)
	
	var _blueTint = fx_create("_filter_tintfilter")
	fx_set_parameter(_blueTint, "g_TintCol", [0, 0, 1, 1])
	fx_set_single_layer(_blueTint, true)
	
	var _yellowTint = fx_create("_filter_tintfilter")
	fx_set_parameter(_yellowTint, "g_TintCol", [1, 1, 0, 1])
	fx_set_single_layer(_yellowTint, true)
	
	if layer_exists("CollisionA")
		layer_set_fx("CollisionA", _redTint)
	if layer_exists("CollisionB")
		layer_set_fx("CollisionB", _blueTint)
	if layer_exists("CollisionSemi")
		layer_set_fx("CollisionSemi", _yellowTint)
	
	show_debug_message("COLLISION COLORS SET")
}

function colour_get_inverse(_color)
{
	var _r = colour_get_red(_color)
	var _g = colour_get_green(_color)
	var _b = colour_get_blue(_color)
	
	var _ir = (255 - _r) mod 256
	var _ig = (255 - _g) mod 256
	var _ib = (255 - _b) mod 256
	
	return make_colour_rgb(_ir, _ig, _ib)
}

function colour_add_hsv(_color, _addHue, _addSaturation, _addValue)
{
	var _h = (colour_get_hue(_color) + _addHue) mod 256
	var _s = clamp((colour_get_saturation(_color) + _addSaturation), 0, 255)
	var _v = clamp((colour_get_value(_color) + _addValue), 0, 255)
	
	return make_colour_hsv(_h, _s, _v)
}

// subpixel
function spx(_amount)
{
	return _amount / 256
}