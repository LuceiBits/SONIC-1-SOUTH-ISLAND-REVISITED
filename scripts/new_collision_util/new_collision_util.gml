function collision_meeting(px, py)
{
	px = floor(px);
	py = floor(py);
	
	var tilemap = layer_tilemap_get_id("CollisionMain");
	var col = instance_position(px, py, tilemap);
	
	if(col)
		return true;
}

function collision_get_height(px, py, mode = CMODE_FLOOR)
{
	// Mandatory flooring
	px = floor(px);
	py = floor(py);
	
	var newX = px;
	var newY = py;
	var maxDist = 32;
	
	switch(mode)
	{
		case CMODE_FLOOR:
		while(!collision_meeting(px, py) && py < newY + maxDist)
			py++;
		
		while(collision_meeting(px, py))
			py--;
		
		return py - newY;
		
		case CMODE_LWALL:
		while(!collision_meeting(px, py) && px < newX + maxDist)
			px++;
		
		while(collision_meeting(px, py))
			px--;
		
		return px - newX;
		
		case CMODE_CEILING:
		while(!collision_meeting(px, py - 1) && py > newY - maxDist)
			py--;
		
		while(collision_meeting(px, py - 1))
			py++;
			
		return py - newY;
		
		case CMODE_RWALL:
		while(!collision_meeting(px - 1, py) && px > newX - maxDist)
			px--;
		
		while(collision_meeting(px - 1, py))
			px++;
			
		return px - newX;
	}
}

function collision_get_angle(px, py, mode = CMODE_FLOOR)
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
	
			while(!collision_meeting(ax, ay) && ay < py + 32)
				ay++;

			while(!collision_meeting(bx, by) && by < py + 32)
				by++;

			while(collision_meeting(ax, ay) && ay > py - 32)
				ay--;

			while(collision_meeting(bx, by) && by > py - 32)
				by--;

		break;
		
		case CMODE_LWALL:
			ax = px;
			bx = px;
			ay = py + (15 - py mod 16);	
			by = py - py mod 16;
	
			while(!collision_meeting(ax, ay) && ax < px + 32)
				ax++;

			while(!collision_meeting(bx, by) && bx < px + 32)
				bx++;

			while(collision_meeting(ax, ay) && ax > px - 32)
				ax--;

			while(collision_meeting(bx, by) && bx > px - 32)
				bx--;
				
		break;
		
		case CMODE_CEILING:
			ax = px + (15 - px mod 16);
			bx = px - px mod 16;
			ay = py;	
			by = py;
	
			while(!collision_meeting(ax, ay) && ay > py - 32)
				ay--;
				
			while(!collision_meeting(bx, by) && by > py - 32)
				by--;

			while(collision_meeting(ax, ay) && ay < py + 32)
				ay++;

			while(collision_meeting(bx, by) && by < py + 32)
				by++;
				
		break;
		
		case CMODE_RWALL:
			ax = px;
			bx = px;
			ay = py - py mod 16;	
			by = py + (15 - py mod 16);
	
			while(!collision_meeting(ax, ay) && ax > px - 32)
				ax--;

			while(!collision_meeting(bx, by) && bx > px - 32)
				bx--;

			while(collision_meeting(ax, ay) && ax < px + 32)
				ax++;

			while(collision_meeting(bx, by) && bx < px + 32)
				bx++;
			
		break;
	}
	
	return point_direction(ax, ay, bx, by);
}

function collision_active_sensor(radius_x, radius_y, mode = CMODE_FLOOR)
{
	var heightL = collision_get_height(x - radius_x, y + radius_y, mode);
	var heightM = collision_get_height(x , y + radius_y, mode);
	var heightR = collision_get_height(x + radius_x, y + radius_y, mode);
	
	var closest = heightL;

	if (heightM < closest)
		closest = heightM;

	if (heightR < closest)
		closest = heightR;

    return closest;
}