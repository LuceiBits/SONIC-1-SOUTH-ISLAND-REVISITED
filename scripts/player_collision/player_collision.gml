function player_collision()
{
	// Player's airborne state
	if(!ground)
	{
		var height = collision_active_sensor(hitbox_w, hitbox_h);
		
		if(height < 0)
		{
			y += height;
			ground = true;	
			
			y_speed = 0;
		}
	}
	else
	{
		var height = collision_active_sensor(hitbox_w, hitbox_h);
		
		y += height;

	}
}