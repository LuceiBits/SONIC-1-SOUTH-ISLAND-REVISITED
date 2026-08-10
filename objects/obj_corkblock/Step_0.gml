live_auto_call

/// @description Script
// Update the culling bounding box to match the moving radius
culling_struct.region.left = old_culling_box.left - range_x - PLATFORM_CULL_W;
culling_struct.region.right = old_culling_box.right + range_x + PLATFORM_CULL_W;
culling_struct.region.top = old_culling_box.top - range_y - PLATFORM_CULL_H;
culling_struct.region.bottom = old_culling_box.bottom + range_y + PLATFORM_CULL_H;

// Make it semi solid and find the player object
var col = player_act_semi_solid();
var p = player_find(0);

// Get the osscilator timer
var timer = obj_level.platform_oscillate_timer;

// Get previous position values
var old_x = x;
var old_y = y;

// Position the platform
//x = round(origin_x + range_x * dsin((timer * x_speed) + angle_x));
//y = round(origin_y + range_y * dcos((timer * y_speed) + angle_y) + sink_offset);

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

if mouse_check_button(mb_left)
{
	x = mouse_x
	y = mouse_y
}

