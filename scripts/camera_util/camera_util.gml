function camera_set_lag(horizontal = -1, vertical = -1)
{
	//Get the camera object
	var camera = instance_find(obj_camera, 0);
	
	//Set horizontal camera lag
	if(horizontal != 1)
	{
		camera.h_lag = horizontal;
	}
	
	//Set vertical camera lag
	if(vertical != 1)
	{
		camera.v_lag = vertical;
	}
}

function camera_set_mode(camera_mode)
{
	obj_camera.mode = camera_mode;
}

function camera_return()
{
	obj_camera.mode = 1;
	obj_camera.target_x = obj_camera.camera_x;
	obj_camera.target_y = obj_camera.camera_y - 16;
	obj_camera.target_right = room_width;
	obj_camera.target_top = 0;
	obj_camera.target_bottom = room_height;
	obj_camera.limit_right = room_width;
	obj_camera.limit_top = 0;
	obj_camera.limit_bottom = room_height;	
}

// Internal

function _camera_boundaries(){
	//Screen values
	var c, cx, cy, sw, sh;
	c = view_camera[view_current]
	cx = camera_get_view_x(c)
	cy = camera_get_view_y(c)
	sw = camera_get_view_width(view_camera[view_current]);
	sh = camera_get_view_height(view_camera[view_current]);
	
	var by = abs(floor(target_y - previous_y));
	
	//Limit bottom
	if(limit_bottom > target_bottom)
	{
		limit_bottom = camera_y + center_y;
		limit_bottom -= 2;
		limit_bottom = max(target_bottom, limit_bottom);
	}
	
	if(limit_bottom < target_bottom)
	{
		limit_bottom += max(by, 2);
		limit_bottom = min(target_bottom, limit_bottom);
	}
	
	if(limit_bottom > cy + sh + 16) limit_bottom = target_bottom;
	
	//Limit top
	if(limit_top < target_top)
	{
		limit_top = camera_y - center_y;
		limit_top += 2;
		limit_top = min(target_top, limit_top);
	}
	
	if(limit_top > target_top)
	{
		limit_top -= 2;
		limit_top = max(target_top, limit_top);
	}
	
	if(limit_top < cy - 16) limit_top = target_top;
	
	//Limit left
	if(limit_left < target_left)
	{
		limit_left = camera_x - center_x;
		limit_left += 2;
		limit_left = min(target_left, limit_left);
	}
	
	if(limit_left > target_left)
	{
		limit_left -= 2;
		limit_left = max(target_left, limit_left);
	}
	
	if(limit_left < cx - 16) limit_left = target_left;
	
	//Limit right
	if(limit_right > target_right)
	{
		limit_right = camera_x + center_x;
		limit_right -= 2;
		limit_right = max(target_right, limit_right);
	}
	
	if(limit_right < target_right)
	{
		limit_right += 2;
		limit_right = min(target_right, limit_right);
	}
	
	if(limit_right > cx + sw + 16) limit_right = target_right;
}