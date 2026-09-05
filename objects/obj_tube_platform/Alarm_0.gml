live_auto_call

tube_id = instance_place(x, y, obj_platform_tube)

if tube_id != noone && !dupe
{
	angle_position_offset = point_distance(0, tube_id.bbox_top, 0, bbox_top)
	angle_position_offset /= tube_id.sprite_width
	angle_position_offset *= 360
	angle_position_offset -= 180
	
	var _set_y = tube_id.y + ((tube_id.sprite_height)/2)
	y = _set_y
	ystart = _set_y
	
	if !dupe
	{
		with instance_create_depth(x, y, depth, obj_tube_platform)
		{
			dupe = true
			image_blend = c_red
			
			angle_position_offset = other.angle_position_offset + 180
		}
	}
}