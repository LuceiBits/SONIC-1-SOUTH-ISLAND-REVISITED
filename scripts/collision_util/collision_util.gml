function collision_get_height(px, py, mode = CMODE_FLOOR, plane = PLANE_A, semi_solid = false)
{
    px = floor(px);
    py = floor(py);

    var best_h = 9999;

    for (var i = 0; i < array_length(global.col_tile); i++)
    {
        var l = global.col_tile[i];
		
		
        if ((!semi_solid && l == "CollisionSemi") ||  (plane != PLANE_A && l == "CollisionA") ||  (plane != PLANE_B && l == "CollisionB"))
        {
            continue;
        }

        var h;

        switch (mode)
        {
            case CMODE_FLOOR:
                h = _tile_get_height(px, py, l);
            break;

            case CMODE_LWALL:
                h = _tile_get_width(px, py, l);
            break;

            case CMODE_CEILING:
                h = _tile_get_height(px, py - 1, l, true);
            break;

            case CMODE_RWALL:
                h = _tile_get_width(px - 1, py, l, true);
            break;
        }

        if (h < best_h)
            best_h = h;
    }

    return best_h;
}

function collision_get_angle(px, py, mode = CMODE_FLOOR, plane = PLANE_A)
{
	px = floor(px);
	py = floor(py);
	
	// Points
	var ax, bx, ay, by; 
	
	switch(mode)
	{
		case CMODE_FLOOR:
			ax = px - px mod 16;
			bx = px + (15 - px mod 16);
			ay = collision_get_height(ax, py, mode, plane, true);	
			by = collision_get_height(bx, py, mode, plane, true);
		break;
		
		case CMODE_LWALL:
			by = py - py mod 16;
			ay = py + (15 - py mod 16);
			ax = collision_get_height(px, ay, mode, plane, true);	
			bx = collision_get_height(px, by, mode, plane, true);
		break;
		
		case CMODE_CEILING:
			bx = px - px mod 16;
			ax = px + (15 - px mod 16);
			by = collision_get_height(ax, py, mode, plane, true);	
			ay = collision_get_height(bx, py, mode, plane, true);
		break;
		
		case CMODE_RWALL:
			ay = py - py mod 16;
			by = py + (15 - py mod 16);
			bx = collision_get_height(px, ay, mode, plane, true);	
			ax = collision_get_height(px, by, mode, plane, true);
		break;
	}
	var angle = point_direction(ax, ay, bx, by);
	
	return angle;
}

function collision_active_sensor(radius_x, radius_y, mode = CMODE_FLOOR, plane = PLANE_A, semi_solid = false)
{
	// Default struct
	var colResult = {
		height : 0,
		angle : 0
	}
	
	//Change direction
	var x_dir = dsin(90 * mode);
	var y_dir = dcos(90 * mode);
	
	// Get the correct point position
	var pxL = x - radius_x * y_dir + radius_y * x_dir;
	var pyL = y + radius_y * y_dir - radius_x * -x_dir;
	
	var pxM = x + 0 * y_dir + radius_y * x_dir;
	var pyM = y + radius_y * y_dir + 0 * -x_dir;
	
	var pxR = x + radius_x * y_dir + radius_y * x_dir;
	var pyR = y + radius_y * y_dir + radius_x * -x_dir;
	
	// Get all of 3 sensors
	var heightL = collision_get_height(pxL, pyL, mode, plane, semi_solid);
	var heightM = collision_get_height(pxM, pyM, mode, plane, semi_solid);
	var heightR = collision_get_height(pxR, pyR, mode, plane, semi_solid);
	
	// Default to the left sensor
	colResult.height = heightL;
	colResult.angle = collision_get_angle(pxL, pyL, mode, plane);
	
	// Set the result to the middle sensor
	if(heightM < colResult.height)
	{
		colResult.height = heightM;
		colResult.angle = collision_get_angle(pxM, pyM, mode, plane);
	}
	
	// Set the result to the right sensor
	if(heightR < colResult.height)
	{
		colResult.height = heightR;
		colResult.angle = collision_get_angle(pxR, pyR, mode, plane);
	}
		
    return colResult;
}

// ==========================================================================================
// Utility script's internal function, do not use them outside
// ==========================================================================================

function _tile_get_height2(xpos, ypos, l = "CollisionMain", flip = false)
{

	xpos = floor(xpos);
	ypos = floor(ypos);
	
	// Get the tile layer
	var layer_id = layer_tilemap_get_id(l);
	
	var cellX = floor(xpos / 16);
	var cellY = floor(ypos / 16);
	
	// Get the height from active tile ID
	var tile_id = tilemap_get(layer_id, cellX, cellY);
	var height = _tiledata_get_height(tile_id, xpos, flip);
	
	// Flip height
	if(flip)
		height = -height;
	
	// Return the correct distance
	if(height > 0)
	{
		return 15 - (height + (ypos & 15));	
			
	}
	else if(height < 0)
	{
		if(height + (ypos & 15) < 0)
			return (ypos & 15) ^ ~0;
	}
	
	return 15 - (ypos & 15);
}

function _tile_get_height(xpos, ypos, l = "CollisionMain", flip = false)
{
	xpos = floor(xpos);
	ypos = floor(ypos);
	
	// Get the tile layer
	var layer_id = layer_tilemap_get_id(l);
	
	// Get cell's position
	var cellX = floor(xpos / 16);
	var cellY = floor(ypos / 16);
	
	// Get the height from active tile ID
	var tile_id = tilemap_get(layer_id, cellX, cellY);
	var height = _tiledata_get_height(tile_id, xpos, flip);
	
	// Second pass offset
	var a = 16;
	
	// Flip everything needed
	if(flip)
	{
		ypos ^= 15
		height = -height;
		a = -a;
	}
	
	// Return the correct distance
	if(height > 0)
	{
		if(height != 16)
		{
			return 15 - (height + (ypos & 15));	
		}
		else
			return _tile_get_height2(xpos, ypos - a, l, flip) - 16;
			
	}
	else
	{
		if(height + (ypos & 15) < 0)
			return _tile_get_height2(xpos, ypos - a, l, flip) - 16; 
	}
	
	return _tile_get_height2(xpos, ypos + a, l, flip) + 16;
}

function _tile_get_width2(xpos, ypos, l = "CollisionMain", flip = false)
{
	xpos = floor(xpos);
	ypos = floor(ypos);
	
	// Get the tile layer
	var layer_id = layer_tilemap_get_id(l);
	
	// Get cell's position
	var cellX = floor(xpos / 16);
	var cellY = floor(ypos / 16);
	
	// Get the height from active tile ID
	var tile_id = tilemap_get(layer_id, cellX, cellY);
	var height = _tiledata_get_width(tile_id, ypos, flip);
	
	// Second pass offset
	var a = 16;
	
	// Flip everything needed
	if(flip)
		height = -height;

	// Return the correct distance
	if(height > 0)
	{
		return 15 - (height + (xpos & 15));	
			
	}
	else if(height < 0)
	{
		if(height + (xpos & 15) < 0)
			return (xpos & 15) ^ ~0;
	}
	
	return 15 - (xpos & 15);
}

function _tile_get_width(xpos, ypos, l = "CollisionMain", flip = false)
{
	xpos = floor(xpos);
	ypos = floor(ypos);
	
	// Get the tile layer
	var layer_id = layer_tilemap_get_id(l);
	
	// Get cell's position
	var cellX = floor(xpos / 16);
	var cellY = floor(ypos / 16);
	
	// Get the height from active tile ID
	var tile_id = tilemap_get(layer_id, cellX, cellY);
	var height = _tiledata_get_width(tile_id, ypos, flip);
	
	// Second pass offset
	var a = 16;
	
	// Flip everything needed
	if(flip)
	{
		xpos ^= 15
		height = -height;
		a = -16;
	}
	
	// Return the correct distance
	if(height > 0)
	{
		if(height != 16)
		{
			return 15 - (height + (xpos & 15));	
		}
		else
			return _tile_get_width2(xpos - a, ypos, l, flip) - 16;
			
	}
	else
	{
		if(height + (xpos & 15) < 0)
			return _tile_get_width2(xpos - a, ypos, l, flip) - 16; 
	}
	
	return _tile_get_width2(xpos + a, ypos, l, flip) + 16;
}

// ==========================================================================================
// Tile data segment
// ==========================================================================================
function _tiledata_get_height(tile_id, xpos, flip = false)
{
	// Turn X position into an offset
	if(!tile_get_mirror(tile_id))
		xpos %= 16;
	else
		xpos = 15 - xpos % 16;
	
	// Get the tile ID
	var index = tile_get_index(tile_id);
	
	// Return blank height if the tile is invalid
	if(index <= 0 || index > array_length(global.tile_top))
	{
		return 0;
	}
	
	// Up direction collision height
	if(flip)
	{
		// Return collision height if the tile is flipped
		if(tile_get_flip(tile_id))
			return -global.tile_top[index][xpos];
		
		// Otherwise default to the normal one
		return -global.tile_bottom[index][xpos];
	}
	else	// Down direction
	{
		// Return collision height if the tile is flipped
		if(tile_get_flip(tile_id))
			return global.tile_bottom[index][xpos];
		
		// Otherwise default to the normal one
		return global.tile_top[index][xpos];
	}
}

function _tiledata_get_width(tile_id, ypos, flip = false)
{
	// Turn X position into an offset
	if(!tile_get_flip(tile_id))
		ypos %= 16;
	else
		ypos = 15 - ypos % 16;
	
	// Get the tile ID
	var index = tile_get_index(tile_id);
	
	// Return blank height if the tile is invalid
	if(index <= 0 || index > array_length(global.tile_top))
	{
		return 0;
	}
	
	// Up direction collision height
	if(flip)
	{
		// Return collision height if the tile is flipped
		if(tile_get_mirror(tile_id))
			return -global.tile_left[index][ypos];	
			
		// Otherwise default to the normal one
		return -global.tile_right[index][ypos];
	}
	else
	{
		// Return collision height if the tile is flipped
		if(tile_get_mirror(tile_id))
			return global.tile_right[index][ypos];
			
		// Otherwise default to the normal one
		return global.tile_left[index][ypos];	
	}
}

// ==========================================================================================
// Deprecated so it doesn't crash the game
// ==========================================================================================
function collision_point_check(radius_x, radius_y, collision_mode = CMODE_FLOOR, collision_plane = PLANE_A, semi_solid = false, solid_object = false)
{

}

function collision_line_check(radius_x, radius_y, collision_mode = CMODE_FLOOR, collision_plane = PLANE_A, semi_solid = false, solid_object = false)
{

}