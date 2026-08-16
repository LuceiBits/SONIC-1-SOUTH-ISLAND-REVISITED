/// @description Values
	sink_offset = 0;
	move_object = [obj_ring, obj_spring_vertical, obj_spring_horizontal, obj_spring_diagonal, obj_monitor];
	origin_x = xstart
	origin_y = ystart
	fall_timer = 60
	fall_speed = 0
	fall_offset = 0
	last_x = 0
	last_y = 0
	top_collision = false
	bottom_collision = false
	grounded = false
	y_speed = 0
	grav = 0.05
	
	depth += 100
	//culling_box = _instance_make_hitbox(id)
	
	//instance_register_culling(culling_box, noone, CULL_FLAG.CHECK_ENTITY_START);
	
	//old_culling_box = 
	//{
	//	left	: culling_struct.region.left,
	//	right	: culling_struct.region.right,
	//	top		: culling_struct.region.top,
	//	bottom	: culling_struct.region.bottom
	//};
	
	attached_list = ds_list_create();
	
	// Append the moving objects in the radius
	var _list = ds_list_create();
	var _num = collision_rectangle_list(x - object_radius_w, y - object_radius_h, x + object_radius_w, y + object_radius_h, move_object, false, true, _list, false);
	
	if (_num > 0)
	{
		for (var i = 0; i < _num; ++i)
		{
		    ds_list_add(attached_list, _list[| i])
		}
	}
	
	ds_list_destroy(_list);
