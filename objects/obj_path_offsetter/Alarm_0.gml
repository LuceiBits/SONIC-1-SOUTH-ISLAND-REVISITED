live_auto_call

var _list = ds_list_create()
var _platforms = instance_place_list(x,y, obj_movingplatform_path, _list, true)

show_debug_message(_platforms)

if _platforms > 0 && !ds_list_empty(_list)
{
	for (var i = 0; i < _platforms; i++)
	{
	    var _platID = ds_list_find_value(_list, i);
		
		with _platID
		{
			if i != 0
			{
				var _newOffset = (1/(_platforms)) * i
				offset = _newOffset
			}
			show_debug_message(offset)
			dir = other.dir
			if other.path != noone
				path = other.path
			spd = other.spd
		}
	}
}

with instance_place(x, y, obj_path_drawer)
{
	if other.path != noone
		path = other.path
}

instance_destroy()