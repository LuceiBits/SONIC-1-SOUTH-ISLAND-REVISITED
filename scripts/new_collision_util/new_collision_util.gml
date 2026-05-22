function collision_meeting(px, py, plane = PLANE_A, semi_solid = false)
{

	//Get the size of collision layer array:
	var a_col = array_length(global.col_tile);
	
	//Handle tile collision (Native GameMaker implementation):
	for (var i = 0; i < a_col; ++i) 
	{
	    //Check if given layers exist(Prevents console output from spamming non existing layer):
		if(position_meeting(px, py, layer_tilemap_get_id(global.col_tile[i])))
		{
			switch(i)
			{
				case 0:
					return true;
				break;
						
				case 1:
					if(semi_solid)
						return true;
				break;
						
				case 2:
					if(plane == PLANE_A)
						return true;
				break;
					
				case 3:
					if(plane == PLANE_B)
						return true;
				break;
			}
		}
		
		
	}
}

function collision_get_height(px, py, mode = CMODE_FLOOR, plane = PLANE_A, semi_solid = false)
{
	// Mandatory flooring
	px = floor(px);
	py = floor(py);
	
	var newX = px;
	var newY = py;
	var maxDist = 16;
	
	switch(mode)
	{
		case CMODE_FLOOR:
			while(!collision_meeting(px, py, plane, semi_solid) && py < newY + maxDist)
				py++;
		
			while(collision_meeting(px, py, plane, semi_solid) && py > newY - maxDist)
				py--;
		
			return py - newY;
		
		case CMODE_LWALL:
			while(!collision_meeting(px, py, plane, semi_solid) && px < newX + maxDist)
				px++;
		
			while(collision_meeting(px, py, plane, semi_solid) && px > newX - maxDist)
				px--;
		
			return px - newX;
		
		case CMODE_CEILING:
			while(!collision_meeting(px, py - 1, plane, semi_solid) && py > newY - maxDist)
				py--;
		
			while(collision_meeting(px, py - 1, plane, semi_solid) && py < newY + maxDist)
				py++;
			
			return newY - py;
		
		case CMODE_RWALL:
			while(!collision_meeting(px - 1, py, plane, semi_solid) && px > newX - maxDist)
				px--;
		
			while(collision_meeting(px - 1, py, plane, semi_solid) && px < newX + maxDist)
				px++;
			
			return newX - px;
	}
}

function collision_get_angle(px, py, mode = CMODE_FLOOR, plane = PLANE_A, semi_solid = false)
{
	// Mandatory flooring
	px = floor(px);
	py = floor(py);
	
	// Points
	var ax, bx, ay, by; 
			
	switch(mode)
	{
		case CMODE_FLOOR:
			ax = px - px mod 16;
			bx = px + (15 - px mod 16);
			ay = py;	
			by = py;
	
			while(!collision_meeting(ax, ay, plane, semi_solid) && ay < py + 32)
				ay++;

			while(!collision_meeting(bx, by, plane, semi_solid) && by < py + 32)
				by++;

			while(collision_meeting(ax, ay, plane, semi_solid) && ay > py - 32)
				ay--;

			while(collision_meeting(bx, by, plane, semi_solid) && by > py - 32)
				by--;

		break;
		
		case CMODE_LWALL:
			ax = px;
			bx = px;
			ay = py + (15 - py mod 16);	
			by = py - py mod 16;
	
			while(!collision_meeting(ax, ay, plane, semi_solid) && ax < px + 32)
				ax++;

			while(!collision_meeting(bx, by, plane, semi_solid) && bx < px + 32)
				bx++;

			while(collision_meeting(ax, ay, plane, semi_solid) && ax > px - 32)
				ax--;

			while(collision_meeting(bx, by, plane, semi_solid) && bx > px - 32)
				bx--;
				
		break;
		
		case CMODE_CEILING:
			ax = px + (15 - px mod 16);
			bx = px - px mod 16;
			ay = py;	
			by = py;
	
			while(!collision_meeting(ax, ay, plane, semi_solid) && ay > py - 32)
				ay--;
				
			while(!collision_meeting(bx, by, plane, semi_solid) && by > py - 32)
				by--;

			while(collision_meeting(ax, ay, plane, semi_solid) && ay < py + 32)
				ay++;

			while(collision_meeting(bx, by, plane, semi_solid) && by < py + 32)
				by++;
				
		break;
		
		case CMODE_RWALL:
			ax = px;
			bx = px;
			ay = py - py mod 16;	
			by = py + (15 - py mod 16);
	
			while(!collision_meeting(ax, ay, plane, semi_solid) && ax > px - 32)
				ax--;

			while(!collision_meeting(bx, by, plane, semi_solid) && bx > px - 32)
				bx--;

			while(collision_meeting(ax, ay, plane, semi_solid) && ax < px + 32)
				ax++;

			while(collision_meeting(bx, by, plane, semi_solid) && bx < px + 32)
				bx++;
			
		break;
	}
	
	return point_direction(ax, ay, bx, by);
}

function collision_active_sensor(radius_x, radius_y, mode = CMODE_FLOOR, plane = PLANE_A, semi_solid = false, angle = true)
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
	
	if(angle)
		colResult.angle = collision_get_angle(pxL, pyL, mode, plane, semi_solid);
	
	// Set the result to the middle sensor
	if(heightM < colResult.height)
	{
		colResult.height = heightM;
		
		if(angle)
			colResult.angle = collision_get_angle(pxM, pyM, mode, plane, semi_solid);
	}
	
	// Set the result to the right sensor
	if(heightR < colResult.height)
	{
		colResult.height = heightR;
		
		if(angle)
			colResult.angle = collision_get_angle(pxR, pyR, mode, plane, semi_solid);
	}
	
    return colResult;
}