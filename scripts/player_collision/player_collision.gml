function player_collision()
{
	// Reset the flag
	on_terrain = false;
	
	// Player's airborne state
	if(!ground)
	{
		// Reset the ground angle to default
		ground_angle = 0;
		
		// Wall collision
		var wallR = collision_get_height(x - wall_w, y, CMODE_RWALL, plane);
		var wallL = collision_get_height(x + wall_w, y, CMODE_LWALL, plane);
		
		// Snap to the wall
		if(wallL <= 0)
			x += wallL;	
			
		if(wallR <= 0)
			x -= wallR;	
			
		// Get the active collision sensor
		var c = collision_active_sensor(hitbox_w, hitbox_h, CMODE_FLOOR, plane, true, false);
		
		// If player is colliding with floor, then ground the player
		if(c.height < 0 && y_speed > 0)
		{
			// Push the player out of the ground
			c = collision_active_sensor(-hitbox_w, hitbox_h, mode, plane, true);
			ground_angle = c.angle;
			ground = true;	
			
			// Landing physics
			ground_speed = x_speed;
			
			// Shallow slopes
			if(abs(x_speed) <= abs(y_speed / 2) && math_uangle(ground_angle) >= 24)
				ground_speed = (y_speed / 2) * -sign(dsin(ground_angle));
			
			// Steep slope landing
			if(abs(x_speed) <= abs(y_speed) && math_uangle(ground_angle) >= 45)
				ground_speed = y_speed * -sign(dsin(ground_angle));
			
			// Trigger the landing callback and mode reposition
			player_land_callback();
			player_mode();
			
			// Get new collision to prevent floor clipping
			c = collision_active_sensor(-hitbox_w, hitbox_h, mode, plane, true);
			
			// Snap player to the floor
			y += c.height * y_dir;
			x += c.height * x_dir;
		
		}
		
		// Wall stoppers
		if(wallL < 0 || wallR < 0)
			x_speed = 0;
	}
	else
	{
		// Wall collision
		var wallR = collision_get_height(x + (wall_w * y_dir), y - (wall_w * x_dir), (CMODE_LWALL + mode) mod 4, plane);
		var wallL = collision_get_height(x - (wall_w * y_dir), y + (wall_w * x_dir), (CMODE_RWALL + mode) mod 4, plane);
		
		// Snap to the left wall with the right sensor
		if(wallR < 0)
		{
			x += wallR * y_dir;	
			y -= wallR * x_dir;	
		}
		
		// Snap to the right wall with the left sensor
		if(wallL < 0)
		{
			x -= wallL * y_dir;	
			y += wallL * x_dir;	
		}
			
		// Get the active sensor
		var c = collision_active_sensor(-hitbox_w, hitbox_h, mode, plane, true);
		
		// Mark the player object to be on terrain
		if(c <= 16)
		{
			on_terrain = true;	
		}
		
		// Get the previous angle and angle from the active sensor
		var oldAngle = ground_angle;
		var newAngle = c.angle;
		
		// Calculate the difference between both of the angles
		var angleDiff = math_uangle(abs(newAngle - oldAngle));
		
		if(!on_object)
		{	
			// If there's nothing below sonic, detach
			if(c.height > (angleDiff > PLAYER_SLOPE_TOLERANCE ? 1 : PLAYER_DETACH_DIST))
			{
				ground = false;
				exit;
			}
		
			// Halt ground snapping and new angle if the difference is above the tolerance
			if(angleDiff > PLAYER_SLOPE_TOLERANCE)
				exit;
		
			// Snap player to the floor
			y += c.height * y_dir;
			x += c.height * x_dir;
		
			// Apply the new angle
			ground_angle = newAngle;
		}
		
		// Wall stoppers
		if(wallR < 0 || wallL < 0)
			ground_speed = 0;
	}
}