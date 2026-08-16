/// @description Script
	// Update the culling bounding box to match the moving radius
	//culling_struct.region.left = old_culling_box.left - range_x - PLATFORM_CULL_W;
	//culling_struct.region.right = old_culling_box.right + range_x + PLATFORM_CULL_W;
	//culling_struct.region.top = old_culling_box.top - range_y - PLATFORM_CULL_H;
	//culling_struct.region.bottom = old_culling_box.bottom + range_y + PLATFORM_CULL_H;
	
	// Make it semi solid and find the player object
	var col = player_act_semi_solid();
	var p = player_find(0);
	
	// Get the osscilator timer
	var timer = obj_level.platform_oscillate_timer;
	
	// Get previous position values
	var old_x = x;
	var old_y = y;
	
	// Position the platform
		x = origin_x

		var c = collision_get_distance(x, bbox_top, COLLISION_MODE.CEILING, PLANE.A, true)
		show_debug_message("CEILING_DISTANCE: " + string(c))
		var b = collision_get_distance(x, bbox_bottom, COLLISION_MODE.FLOOR, PLANE.A, true)
		show_debug_message("GROUND_DISTANCE: " + string(b))


		if b < 0 && top_collision = false
		{
		grounded = true
		y_speed = 0
		y += b
		}
				
		if c < 0 && grounded = false
		{
		top_collision = true
		y_speed = 0
		y -= c 
		}

		if obj_water.y < y && top_collision = false
		{
		
		y_speed -= 0.1
		grounded = false
		}

		if obj_water.y > y && grounded = false
		{
		y_speed += 0.1
		top_collision = false
		}

		y_speed = math_approach(y_speed,0,grav)
		if abs(y - obj_water.y) < 1 && abs(y_speed) < 0.11
		{
		y_speed = 0
		y = obj_water.y
		}
			
		y += (y_speed)
		

		
		
		
	
		
	
	
	



		

		

		

		
		
	// Sink the platform
	var sinkcond = sink && col && p.ground;
	sink_offset = lerp(sink_offset, 8 * sinkcond, 0.2);
	
	// Move the player
	if(col && p.ground)
	{
		p.x += x - old_x;
		p.y += y - old_y;
	}
	
	// Carry attached objects
	var inst;
	for (var i = 0; i < ds_list_size(attached_list); ++i) 
	{
		inst = attached_list[| i];
		
		inst.x += x - old_x;
		inst.y += y - old_y;
	}